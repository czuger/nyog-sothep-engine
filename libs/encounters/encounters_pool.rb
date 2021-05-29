require 'hazard'
require_relative 'encounter'
require_relative 'hand'

class EncountersPool

  attr_accessor :monsters_pool

  MONSTERS_INIT_TOKENS = [
      [6, :reves], [8, :goules],
  ]

  # MONSTERS_INIT_TOKENS = [
  #   [1, :horreur_volante], [2, :tempete], [8, :goules], [3, :choses_brume], [2, :teleportation], [4, :habitants],
  #   [10, :fanatiques], [8, :profonds], [6, :reves]
  # ]

  # MONSTERS_INIT_TABLE = [
  #     [3, :horreur_volante], [8, :tempete], [9, :goules], [11, :choses_brume], [11, :teleportation], [14, :habitants],
  #     [17, :fanatiques], [19, :profonds], [42, :reves]
  # ]

  MONSTERS_INIT_TABLE = [
    [42, :reves], [9, :goules]
  ]

  def initialize(map)
    @map = map
    @encounters_pool = Hand.new
    MONSTERS_INIT_TOKENS.each do |e|
      @encounters_pool.set(e[1], e[0])
    end
    @monster_table = WeightedTable.from_weighted_table( MONSTERS_INIT_TABLE)
  end

  def pick_encounter
    loop do
      raise StandardError.new 'encounters_pool is empty (#{@encounters_pool})' if @encounters_pool.empty?

      monster_choice = @monster_table.sample
      puts "Picking encounter : #{monster_choice} (#{@encounters_pool.content})"

      unless @encounters_pool.exhausted? monster_choice
        @encounters_pool.remove monster_choice
        return monster_choice
      end
    end
  end

  def resolve_encounter(investigator)
    encounter = @map[investigator.location]
    if encounter
      result = Encounter.send(encounter, investigator)
      @encounters_pool.add(encounter) if result.return_in_monster_pool
      @map.delete(investigator.location) if result.remove_from_map
      return result.investigator
    end
    investigator
  end
end
