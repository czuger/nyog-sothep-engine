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

  def destinations_choice(location)
    Hash[destinations(location).each_with_index.map { |x,i| [i, x] }]
  end

  def input(msg, default = nil)
    input = default
    unless input
      puts msg
      input = gets.chomp
      unless names.include?(input.to_sym)
        raise StandardError.new "#{input} invalid. (#{@locations.names})"
      end
    end
    input.to_sym
  end

  def input_destination(msg, destinations)
      puts msg
      input = gets.chomp.to_i
      until destinations.keys.include? input
        puts 'Wrong destination'
        input = gets.chomp.int
    end
    destinations[input]
  end

end