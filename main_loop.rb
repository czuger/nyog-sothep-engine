require_relative 'models/board_element_investigator'
require_relative 'models/board_element_professor'
require_relative 'models/map_cities'

locations = MapLocations.new
cities = MapCities.new

investigators = 1.upto(4).map{ BoardElementInvestigator.new }

professor = BoardElementProfessor.new.prof_input cities, start=:milford, invoc=:taunton
p professor

loop do
  destinations = locations.destinations(professor.location)
  destinations_choice = locations.destinations_choice professor.location

  puts 'Where does the prof goes ?'
  p destinations_choice

  next_location = locations.input_destination 'Where does the prof goes ?', destinations_choice

  if destinations.include?(next_location)
    professor.location = next_location
  else
    puts "#{next_location} invalid. (#{destinations})"
  end

  break if next_location == ''
end


