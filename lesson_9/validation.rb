module Validation
  def self.included(cls)
    cls.extend  ClassMethods
    cls.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, opt = nil)
      case type
      when :presence then validate_presence(name)
      when :format   then validate_format(name, opt)
      when :type     then validate_type(name, opt)
      else raise "Неправильный формат"
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

  module InstanceMethods
    def validate!(name, type, opt = nil)
      self.class.validate(name, type, opt)
    end
  end
end
