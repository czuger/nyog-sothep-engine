require 'drizzt'
require_relative 'investigators_pool'
require_relative 'encounters'

class InvestigatorsPool

  def initialize
    @investigators = 1.upto(4).map{ BoardElementInvestigator.new }
    @movement_graph = DrizztGraph.new
    @movement_graph.load_flat_table 'data/destinations.yaml'
    @encounters = Events.new
  end

  def play(professor)
    @investigators.each do |investigator|
      dest = @movement_graph.find_path(investigator.location, professor.location)
      puts "#{investigator.name} moving to #{dest.next_step}"
      investigator.location = dest.next_step

      investigator = @encounters.resolve(investigator)
    end
  end
end
