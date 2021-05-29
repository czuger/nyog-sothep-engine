require 'hazard'
require_relative 'board_element'
require_relative 'map_cities'
require_relative 'encounters/encounters_pool'
require_relative 'encounters/hand'

class BoardElementProfessor < BoardElement

  attr_accessor :hand, :location, :encounters_pool

  def initialize(map, location, nyog_sothep_location)
    super()
    @location = location
    @nyog_sothep_location = nyog_sothep_location
    @encounters_pool = EncountersPool.new map
    @hand = Hand.new
    1.upto(4).each{ |e| @hand.add(@encounters_pool.pick_encounter) }
  end

end