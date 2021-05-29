require 'ostruct'


class Encounter

  def self.reves(investigator)
    investigator.san -= 2
    OpenStruct.new({ investigator: investigator, return_in_monster_pool: true, remove_from_map: true })
  end

  def self.goules(investigator)
    result = OpenStruct.new({ investigator: investigator })
    san_loss = 4

    if investigator.items.gun
      result.remove_from_map = true
      result.return_in_monster_pool = true

      if Hazard.d6 >= 5
        san_loss = 2
      else
        san_loss = 3
      end
    end

    san_loss -= 1 if investigator.items.sign
    investigator.san -= san_loss
    puts "#{investigator.name} fait un rêve et perds #{san_loss} SAN -> (#{investigator.san})"
    result
  end
end
