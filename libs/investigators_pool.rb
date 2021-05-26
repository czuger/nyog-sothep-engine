require 'drizzt'
require_relative 'investigators_pool'

class InvestigatorsPool

  def initialize
    @investigators = 1.upto(4).map{ BoardElementInvestigator.new }
    @movement_graph = DrizztGraph.new
    @movement_graph.load_flat_table 'data/destinations.yaml'
  end

  def play(professor)
    @investigators.each do |investigator|
      p @movement_graph.find_path(investigator.location, professor.location)
    end
  end
end
