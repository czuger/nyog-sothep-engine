require_relative 'libs/board_element_investigator'
require_relative 'libs/board_element_professor'
require_relative 'libs/map_cities'
require_relative 'libs/monsters_pool'
require_relative 'libs/player_interface'
require_relative 'libs/investigators_pool'

investigators = InvestigatorsPool.new
pi = PlayerInterface.new
map = {}


professor = pi.prof_setup :milford, :taunton
p professor

loop do
  next_location = pi.input_destination professor

  professor.location = next_location

  monster = pi.input_monsters_choice(professor)

  professor.hand.delete(monster)

  map[professor.location] = monster

  professor.hand << professor.monsters_pool.pick_monster

  investigators.play(professor)
end


