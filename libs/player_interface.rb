require_relative 'board_element_professor'

class PlayerInterface

  def initialize
    @locations = MapLocations.new
    @cities = MapCities.new
  end

  def input_monsters_choice(professor)
    choice = Hash[([:nothing]+professor.hand.keys).each_with_index.map { |x,i| [i, x] }]
    input = nil

    loop do
      puts 'What does the prof place ?'
      p choice
      input = gets.chomp.to_i
      if choice[input]
        # p cities.port?(professor.location)
        if choice[input] == :profonds && !@cities.port?(professor.location)
          puts "'Profonds can't be placed in ports only'"
        else
          break
        end
      else
        puts "#{input} invalid. (#{choice})"
      end
    end

    choice[input]
  end

  def prof_setup(map, start = nil, invoc = nil )
    location = start || @cities.input('Input the starting location of the prof.')
    nyog_sothep_location = invoc || @cities.input('Input the invocation location.')
    BoardElementProfessor.new(map, location, nyog_sothep_location)
  end

  def location_input(cities, msg)
    puts msg
    input = gets.chomp
    unless cities.names.include?(input.to_sym)
      raise StandardError.new "#{input} invalid. (#{@locations.names})"
    end
    input.to_sym
  end

  def input_destination(prof)
    destinations = @locations.destinations(prof.location)
    destinations_choice = Hash[destinations.each_with_index.map { |x,i| [i, x] }]
    input = nil

    loop do
      puts 'Where does the prof goes ?'
      p destinations_choice
      input = gets.chomp.to_i

      break if destinations_choice[input]
      puts 'Wrong destination'
    end
    destinations[input]
  end

end