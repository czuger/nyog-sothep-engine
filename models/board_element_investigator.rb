require 'hazard'
require_relative 'board_element'

class BoardElementInvestigator < BoardElement

  @@names = %w( poirot hercule hastings le_capitaine sandy lemon )

  def initialize
    super
    @location = :nantucket
    @san = Hazard.d3d6
    @name = @@names.sample
    @@names.delete(@name)
  end

end