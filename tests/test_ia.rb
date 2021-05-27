require 'minitest/autorun'
require_relative '../libs/investigators_ia'
require_relative '../libs/player_interface'

class TestIA < MiniTest::Unit::TestCase

  def setup
    @ia = InvestigatorsIA.new
    pi = PlayerInterface.new
    @professor = pi.prof_setup :milford, :taunton
  end

  def test_prof_3
    @ia.prof_localized(:prof_3, @professor)

    p @ia.target_position
  end
end