require 'hazard'
require_relative 'board_element'
require_relative 'map_cities'

class BoardElementProfessor < BoardElement

  def initialize
    super
    @nyog_sothep_location = nil
  end

  def prof_input( cities, start = nil, invoc = nil )
    @location = cities.input('Input the starting location of the prof.', default=start)
    @nyog_sothep_location = cities.input('Input the invocation location.', default=invoc)
    self
  end
end