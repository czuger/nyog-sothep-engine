require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative '../libs/investigators_ia'
require_relative '../libs/player_interface'
require_relative '../libs/board_element_investigator'

class TestIA < MiniTest::Unit::TestCase

  def setup
    @ia = InvestigatorsIA.new
    pi = PlayerInterface.new
    @professor = pi.prof_setup({}, :milford, :taunton)
    @investigator = BoardElementInvestigator.new
  end

  def test_prof_3
    @ia.prof_localized(:prof_3, @professor)
    @ia.target_position @investigator
  end
end