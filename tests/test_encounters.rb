require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative '../libs/investigators_ia'
require_relative '../libs/player_interface'
require_relative '../libs/board_element_investigator'

class TestEncounters < MiniTest::Unit::TestCase

  def setup
    @ia = InvestigatorsIA.new
    pi = PlayerInterface.new
    @map = {}
    @professor = pi.prof_setup(@map, :milford, :taunton)
    @investigator = BoardElementInvestigator.new
    @investigator.location = :woonsocket
  end

  def test_goules
    @map[:woonsocket] = :goules
    @professor.encounters_pool.resolve_encounter(@investigator)
  end

  def test_goules_with_gun
    @investigator.items.gun = true
    @map[:woonsocket] = :goules
    @professor.encounters_pool.resolve_encounter(@investigator)
  end

  def test_dreams
    @map[:woonsocket] = :reves
    @professor.encounters_pool.resolve_encounter(@investigator)
  end

end