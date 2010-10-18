module AttrCallback
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_callback(*args)
      for name in args
        attr_writer name
        define_method(name) do |*args, &block|
          raise ArgumentError, "wrong number of arguments (#{args.length} for 0)" unless args.empty?
          if block.nil?
            instance_variable_get("@#{name}")
          else
            __send__("#{name}=", block)
          end
        end
      end
    end
  end
end

class Module
  include AttrCallback::ClassMethods    # Make attr_callback available in every module.
end
