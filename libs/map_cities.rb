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

end