require 'hazard'
require_relative 'board_element'
require_relative 'map_cities'

class BoardElementProfessor < BoardElement

  attr_accessor :hand

  def initialize(monsters_pool)
    super()
    @nyog_sothep_location = nil
    @hand = monsters_pool.pick_monsters(4)
    @choice = nil
  end

  def prof_input( cities, start = nil, invoc = nil )
    @location = cities.input('Input the starting location of the prof.', default=start)
    @nyog_sothep_location = cities.input('Input the invocation location.', default=invoc)
    self
  end

  def monsters_placement(map)
    @choice = Hash[([:nothing]+@hand).each_with_index.map { |x,i| [i, x] }]
    puts 'What does the prof place ?'
    p @choice

    monster_id = input_monster_choice
    p monster_id

    map[@location] = @choice[monster_id]
    @hand.delete(@choice[monster_id])
    map
  end

  def input_monster_choice
    loop do
      input = gets.chomp.to_i
      return input if @choice[input]
      puts "#{input} invalid. (#{@choice})"
    end
  end
end