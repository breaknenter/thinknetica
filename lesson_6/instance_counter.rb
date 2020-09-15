module InstanceCounter
  def self.included(cls)
    cls.extend  ClassMethods
    cls.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances
      self.class.instances += 1
    end
  end
end
