class Events

  def initialize
    @events_table = YAML.load_file('data/events.yaml')
  end

  def san(investigator, event)
    if event.san
      investigator.san += event.san
      puts "#{investigator.name} SAN modified by #{event.san} -> #{investigator.san}"
    end
    investigator
  end

  def get_item(investigator, event)
    if event.found
      puts "#{investigator.name} found #{event.found}"
      investigator.items[event.found] = true
    end
    investigator
  end

  def actions(investigator, event, professor, ia)
    if event.action
      if [:prof_1, :prof_2, :prof_3].include?(event.action)
        ia.prof_localized(event.action, professor)
        puts "#{investigator.name} got #{event.action}"
      end
    end
    investigator
  end

  def resolve(investigator, professor, ia)
    nb_dice = 1
    nb_dice += 1 if investigator.items.sign
    nb_dice += 1 if investigator.items.sign && investigator.items.medaillon

    table = Hazard.d2
    result = Hazard.from_string("s#{nb_dice}d6")

    event = @events_table[table][result.result]
    investigator = san(investigator, event)
    investigator = get_item(investigator, event)
    investigator = actions(investigator, event, professor, ia)

    investigator
  end
end