require 'hazard'
require_relative 'board_element'
require_relative 'map_cities'

class BoardElementProfessor < BoardElement

  attr_accessor :hand

  def initialize(monsters_pool)
    super()
    @nyog_sothep_location = nil
    @hand = monsters_pool.pick_monsters(4)
    @choice = nil
  end

  def prof_input( cities, start = nil, invoc = nil )
    @location = cities.input('Input the starting location of the prof.', default=start)
    @nyog_sothep_location = cities.input('Input the invocation location.', default=invoc)
    self
  end

end