require_relative 'libs/board_element_investigator'
require_relative 'libs/board_element_professor'
require_relative 'libs/map_cities'
require_relative 'libs/monsters_pool'
require_relative 'libs/player_interface'

pi = PlayerInterface.new
map = {}
investigators = 1.upto(4).map{ BoardElementInvestigator.new }

professor = pi.prof_setup :milford, :taunton
p professor

loop do
  next_location = pi.input_destination professor

  professor.location = next_location

  monster = pi.input_monsters_choice(professor)

  professor.hand.delete(monster)

  map[professor.location] = monster

  professor.hand << professor.monsters_pool.pick_monster
end


