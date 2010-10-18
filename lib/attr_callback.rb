module AttrCallback
  def self.included(base)
    base.extend(ClassMethods)
  end

  module Util
    NoopProc = Proc.new{}

    class <<self
      def get_or_create_mutex(obj, name)
        mutex = obj.instance_variable_get("@#{name}_lock")
        if mutex.nil?
          obj.instance_variable_set("@#{name}_lock", Mutex.new)
        else
          mutex
        end
      end

      def define_callback_on_class(klass, name, options={})
        name = name.to_sym
        locking = options[:lock].nil? ? true : options[:lock]
        noop = options[:noop].nil? ? true : options[:noop]

        # Define the setter.  If the user specified :lock=>true, then the
        # setter will synchronize on @name_lock; otherwise, we just use
        # the standard attr_writer.
        if locking
          klass.__send__(:define_method, "#{name}=") do |value|
            AttrCallback::Util.get_or_create_mutex(self, name).synchronize {
              instance_variable_set("@#{name}", value)
            }
          end
        else
          klass.__send__(:attr_writer, name)
        end

        # Define the getter.  If the user specified :lock=>true, then the
        # getter will synchronize on @name_lock; otherwise, it won't.
        klass.__send__(:define_method, name) do |*args, &block|
          raise ArgumentError, "wrong number of arguments (#{args.length} for 0)" unless args.empty?

          if block.nil?
            if locking
              callback = AttrCallback::Util.get_or_create_mutex(self, name).synchronize { instance_variable_get("@#{name}") }
            else
              callback = instance_variable_get("@#{name}")
            end
            if noop and callback.nil?
              NoopProc
            else
              callback
            end
          else
            __send__("#{name}=", block)
          end
        end
      end
    end
  end

  module ClassMethods
    def attr_callback(*args)
      # Last argument may be a hash of options.
      if args[-1].is_a?(Hash)
        options = args.pop
      else
        options = {}
      end

      for name in args
        AttrCallback::Util.define_callback_on_class(self, name, options)
      end
    end
  end

end

class Module
  include AttrCallback::ClassMethods    # Make attr_callback available in every module.
end
