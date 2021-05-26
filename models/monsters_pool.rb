require 'hazard'

class MonstersPool

  attr_accessor :monsters_pool

  MONSTERS_INIT_TOKENS = [
      [1, :horreur_volante], [2, :tempete], [8, :goules], [3, :choses_brume], [2, :teleportation], [4, :habitants],
      [10, :fanatiques], [8, :profonds], [6, :reves]
  ]

  MONSTERS_INIT_TABLE = [
      [3, :horreur_volante], [8, :tempete], [9, :goules], [11, :choses_brume], [11, :teleportation], [14, :habitants],
      [17, :fanatiques], [19, :profonds], [42, :reves]
  ]

  def initialize
    @monsters_pool = MONSTERS_INIT_TOKENS.map{ |e| Array.new(*e) }.flatten
    @monster_table = WeightedTable.from_weighted_table( MONSTERS_INIT_TABLE)
  end

  def pick_monster
    loop do
      monster_choice = @monster_table.sample
      if @monsters_pool.include?(monster_choice)
        @monsters_pool.delete(monster_choice)
        return monster_choice
      end
    end
  end

  def pick_monsters(amount)
    1.upto(4).map{ |e| pick_monster }
  end
end
