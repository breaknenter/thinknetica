module Accessors
  def self.included(cls)
    cls.extend  ClassMethods
    cls.include InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*props)
      props.each do |prop|
        name    = "@#{prop}"
        history = "@#{prop}_history"

        define_method("#{prop}_history") { instance_variable_get(history) }

        define_method(prop) { instance_variable_get(name) }
        define_method("#{prop}=") do |val|
          instance_variable_set(name, val)
          instance_variable_get(history) || instance_variable_set(history, [])
          instance_variable_get(history).push(val)
        end
      end
    end

    def strong_attr_accessor(prop, obj)
      define_method(prop) { instance_variable_get(name) }
      define_method("#{prop}=") do |val|
        raise "Значение не является инстансом #{obj}" unless val.kind_of?(obj)
        instance_variable_set("@#{prop}", val)
      end
    end
  end

  module InstanceMethods
  end
end

class Test
  include Accessors

  attr_accessor_with_history :x, :y, :z
end

test = Test.new
test.x = 100
test.x = 200
test.x_history
