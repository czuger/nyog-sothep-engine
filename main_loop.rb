require_relative 'libs/board_element_investigator'
require_relative 'libs/board_element_professor'
require_relative 'libs/map_cities'
require_relative 'libs/encounters/encounters_pool'
require_relative 'libs/player_interface'
require_relative 'libs/investigators_pool'

investigators = InvestigatorsPool.new
pi = PlayerInterface.new
map = {}
cities = MapCities.new


professor = pi.prof_setup map,:milford, :taunton
p professor

loop do
  p map
  next_location = pi.input_destination professor

  professor.location = next_location

  unless map[professor.location]
    if cities.city?(professor.location)
      monster = pi.input_monsters_choice(professor)
      professor.hand.remove(monster)
      map[professor.location] = monster
    end
  end

  professor.hand.add(professor.encounters_pool.pick_encounter)

  investigators.play(map, professor)
end


