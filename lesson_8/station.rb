# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  NAME_EXP = /
    ^[А-ЯЁ][а-яё]{2,15}$ # Название населённого пункта с заглавной буквы (3..16 букв)
  /x.freeze

  attr_reader :name

  @@stations = []

  class << self
    def all
      @@stations
    end

    def find(name:)
      @@stations.find { |station| name == station.name }
    end
  end

  def initialize(name:)
    @name = name
    valid!
    @trains = []

    @@stations << self

    register_instance
  end

  def arrival(train:)
    @trains << train
  end

  def depart(train:)
    @trains.delete(train)
  end

  def each_trains
    raise 'Нет поездов на станции' if @trains.empty?

    @trains.each { |train| yield train }
  end

  def to_s
    @name.to_s
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def valid!
    raise 'Название указано неправильно' if name !~ NAME_EXP
  end
end
