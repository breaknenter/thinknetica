module Validation
  def self.included(cls)
    cls.extend  ClassMethods
    cls.include InstanceMethods
  end

  module ClassMethods

    attr_reader :validates

    def validate(name, type, opt = nil)
      @validates ||= []
      @validates << [name, type, opt]
      # instance_variable_set("@validates", [name, type, opt])
    end

  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |el|
        name, type, opt = el
        val = instance_variable_get("@#{name}")

        case type
        when :presence then validate_presence(val)
        when :format   then validate_format(val, opt)
        when :type     then validate_type(val, opt)
        end
      end
    end

    private

    def validate_presence(name)
      raise "Значение не может быть пустым" if name.nil? || name.empty?
    end

    def validate_format(name, exp)
      raise "Неправильный формат" if name !~ exp
    end

    def validate_type(obj, type)
      raise "Не является инстансом #{type}" unless obj.kind_of?(type)
    end
  end
end
