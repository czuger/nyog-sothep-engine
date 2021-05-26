require_relative 'libs/board_element_investigator'
require_relative 'libs/board_element_professor'
require_relative 'libs/map_cities'
require_relative 'libs/monsters_pool'
require_relative 'libs/player_interface'

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

  monster = PlayerInterface.input_monsters_choice(professor, cities)

  professor.hand.delete(monster)
  map[professor.location] = monster
  professor.hand << monsters_pool.pick_monster
end


