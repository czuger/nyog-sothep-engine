require_relative 'models/board_element_investigator'
require_relative 'models/board_element_professor'
require_relative 'models/map_cities'
require_relative 'models/monsters_pool'

locations = MapLocations.new
cities = MapCities.new
map = {}

investigators = 1.upto(4).map{ BoardElementInvestigator.new }

monsters_pool = MonstersPool.new
professor = BoardElementProfessor.new(monsters_pool).prof_input cities, start=:milford, invoc=:taunton
p professor

loop do
  destinations = locations.destinations(professor.location)
  destinations_choice = locations.destinations_choice professor.location

  p map

  puts 'Where does the prof goes ?'
  p destinations_choice

  next_location = locations.input_destination 'Where does the prof goes ?', destinations_choice

  if destinations.include?(next_location)
    professor.location = next_location
  else
    puts "#{next_location} invalid. (#{destinations})"
  end

  break if next_location == ''

  map = professor.monsters_placement map
  professor.hand << monsters_pool.pick_monster
end


