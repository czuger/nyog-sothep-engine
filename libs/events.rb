class Events

  def initialize
    @encounters_table = YAML.load_file('data/encounters.yaml')
  end

  def san(investigator, encounter)
    if encounter.san
      investigator.san += encounter.san
      puts "#{investigator.name} SAN modified by #{encounter.san} -> #{investigator.san}"
    end
    investigator
  end

  def get_item(investigator, encounter)
    if encounter.found
      puts "#{investigator.name} found #{encounter.found}"
      investigator.items[encounter.found] = true
    end
    investigator
  end

  def resolve(investigator)
    nb_dice = 1
    nb_dice += 1 if investigator.items.sign
    nb_dice += 1 if investigator.items.sign && investigator.items.medaillon

    table = Hazard.d2
    result = Hazard.from_string("s#{nb_dice}d6")

    encounter = @encounters_table[table][result.result]
    investigator = san(investigator, encounter)
    investigator = get_item(investigator, encounter)

    investigator
  end
end