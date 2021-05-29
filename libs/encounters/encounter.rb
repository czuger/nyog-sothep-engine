require 'ostruct'


class Encounter

  def self.reves(investigator)
    investigator.san -= 2
    puts "#{investigator.name} est perturbé par les rèves et perds 2 SAN -> (#{investigator.san})"
    OpenStruct.new({ investigator: investigator, return_in_monster_pool: true, remove_from_map: true })
  end

  def self.profonds(investigator)
    result = OpenStruct.new({ investigator: investigator })
    if investigator.items.sign
      san_loss = 1
      investigator.items.sign = false
      result.remove_from_map = true
      result.return_in_monster_pool = true
    else
      san_loss = 3
    end
    investigator.san -= san_loss
    puts "#{investigator.name} rencontre des profonds et perds #{san_loss} SAN -> (#{investigator.san})"
    result
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
    puts "#{investigator.name} rencontre des goules et perds #{san_loss} SAN -> (#{investigator.san})"
    result
  end
end
