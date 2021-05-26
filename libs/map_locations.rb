require 'ostruct'

class MapLocations

  def initialize
    @locations = {}

    loaded_locations = YAML.load_file('data/locations.yaml')
    loaded_destinations = YAML.load_file('data/destinations.yaml')

    loaded_locations.each do |k, v|
      @locations[k] = OpenStruct.new(
        {
          location: k, area_type: v[:klass] == :c ? :city : :water_area, x: v[:x], y: v[:y], port: v[:port],
          destinations: loaded_destinations[k]
        }
      )
    end
  end

  def names
    @locations.values.map{ |e| e.location }
  end

  def destinations(location)
    @locations[location].destinations
  end
end