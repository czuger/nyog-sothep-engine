class PlayerInterface

  def self.input_monsters_choice(professor, cities)
    choice = Hash[([:nothing]+professor.hand).each_with_index.map { |x,i| [i, x] }]
    input = nil

    loop do
      puts 'What does the prof place ?'
      p choice
      input = gets.chomp.to_i
      if choice[input]
        # p cities.port?(professor.location)
        if choice[input] == :profonds && !cities.port?(professor.location)
          puts "Profonds can't be placed in ports only"
        else
          break
        end
      else
        puts "#{input} invalid. (#{choice})"
      end
    end

    choice[input]
  end


  def input_monster_choice
  end

end