require_relative 'map_locations'

class MapCities < MapLocations
  attr_reader :cities

  def initialize
    super
    @locations.reject!{ |k, v| v.area_type == :city }
  end

end