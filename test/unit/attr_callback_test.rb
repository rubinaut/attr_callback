require File.dirname(__FILE__) + "/../test_helper.rb"
require 'attr_callback'

class AttrCallbackTest < Test::Unit::TestCase
  def test_simple
    klass = Class.new do
      attr_callback :cb
    end
    obj = klass.new
    assert_equal AttrCallback::Util::NoopProc, obj.cb, "initial callback should be NoopProc"
    assert_kind_of Mutex, obj.instance_variable_get("@cb_lock"), "lock should be created when :lock option is unspecified"

    obj.cb = 1
    assert_equal 1, obj.cb, "setter should work"

    block = Proc.new{ nil }
    obj.cb(&block)
    assert_equal block, obj.cb, "block setter should work"
  end

  def test_simple_without_locking
    klass = Class.new do
      attr_callback :cb, :lock=>false
    end
    obj = klass.new
    assert_equal AttrCallback::Util::NoopProc, obj.cb, "initial callback should be NoopProc"
    assert_nil obj.instance_variable_get("@cb_lock"), "lock should not be created when :lock=>false"

    obj.cb = 1
    assert_equal 1, obj.cb, "setter should work"

    block = Proc.new{ nil }
    obj.cb(&block)
    assert_equal block, obj.cb, "block setter should work"
  end

  def test_multiple_callbacks_should_be_independent
    klass = Class.new do
      attr_callback :a, :b
      attr_callback :c, :d
    end
    obj = klass.new

    obj.a = 1
    obj.b = 2
    obj.c = 3
    obj.d = 4

    assert_equal [1, 2, 3, 4], [obj.a, obj.b, obj.c, obj.d]
  end

  def test_multiple_callbacks_should_be_independent_without_locking
    klass = Class.new do
      attr_callback :a, :b, :lock=>false
      attr_callback :c, :d, :lock=>false
    end
    obj = klass.new

    obj.a = 1
    obj.b = 2
    obj.c = 3
    obj.d = 4

    assert_equal [1, 2, 3, 4], [obj.a, obj.b, obj.c, obj.d]
  end

  def test_no_noop
    klass = Class.new do
      attr_callback :cb, :noop=>false
    end
    obj = klass.new
    assert_nil obj.cb
    assert_kind_of Mutex, obj.instance_variable_get("@cb_lock"), "lock should be created when :lock option is unspecified"
  end

  def test_no_noop_without_locking
    klass = Class.new do
      attr_callback :cb, :noop=>false, :lock=>false
    end
    obj = klass.new
    assert_nil obj.cb
    assert_nil obj.instance_variable_get("@cb_lock"), "lock should not be created when :lock=>false"
  end
end
