require 'hazard'
require 'ostruct'
require_relative 'board_element'

class BoardElementInvestigator < BoardElement

  attr_reader :name
  attr_accessor :items, :san, :location

  @@names = %w( poirot hercule hastings le_capitaine sandy lemon )

  def initialize
    super
    # @location = :nantucket
    @location = :boston
    @san = Hazard.d3d6 + 3
    @name = @@names.sample
    @@names.delete(@name)
    @items = OpenStruct.new(gun: false, medaillon: false, sign: false, repel: false)
  end

end