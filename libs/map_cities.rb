require 'pp'
require_relative 'map_locations'

class MapCities < MapLocations
  attr_reader :cities

  def initialize
    super
    @locations.reject!{ |k, v| v.area_type != :city }
    # pp @locations
  end

  def port?(location)
    # p location
    # p @locations[location]
    @locations[location]&.port
  end

  def random_city(exclusion=nil)
    loop do
      city = @locations.keys.sample
      return city unless exclusion == city
    end
  end

  def city?(location)
    @locations[location]
  end

end