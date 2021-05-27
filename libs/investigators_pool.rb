require 'drizzt'
require_relative 'investigators_pool'
require_relative 'events'
require_relative 'investigators_ia'
require_relative 'map_cities'

class InvestigatorsPool

  def initialize
    @investigators = 1.upto(4).map{ BoardElementInvestigator.new }
    @movement_graph = DrizztGraph.new
    @movement_graph.load_flat_table 'data/destinations.yaml'
    @events = Events.new
    @ia = InvestigatorsIA.new
    @cities = MapCities.new
  end

  def play(professor)
    @investigators.each do |investigator|
      puts '*'*100
      puts "Turn of #{investigator.name} (#{investigator.location})"
      puts '*'*100

      dest = @ia.target_position
      puts "Destination = #{dest}"

      dest = @movement_graph.find_path(investigator.location, dest)
      puts "#{investigator.name} moving to #{dest.next_step}"
      investigator.location = dest.next_step

      if @cities.city?(investigator.location)
        investigator = @events.resolve(investigator, professor, @ia)
      end

      puts '*'*100
      puts
    end

    puts '*'*100
    puts 'IA'
    puts '*'*100
    @ia.confidence_lowered
    p @ia.positions
    puts '*'*100

  end
end
