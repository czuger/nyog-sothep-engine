require 'hazard'
require_relative 'board_element'
require_relative 'map_cities'

class BoardElementProfessor < BoardElement

  attr_accessor :hand, :location, :monsters_pool

  def initialize(location, nyog_sothep_location)
    super()
    @location = location
    @nyog_sothep_location = nyog_sothep_location
    @monsters_pool = MonstersPool.new
    @hand = @monsters_pool.pick_monsters(4)
  end

end