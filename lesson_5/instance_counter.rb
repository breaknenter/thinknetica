module InstanceCounter
  def self.included(cls)
    cls.extend  ClassMethods
    cls.include InstanceMethods
  end

  module ClassMethods
    def init_count
      @@instances ||= 0
    end

    def count
      @@instances
    end

    def plus_one
      @@instances += 1
    end
  end

  module InstanceMethods
    private

    def inc_count
      self.class.init_count
      self.class.plus_one
    end
  end
end
