require_relative 'map_cities'

class InvestigatorsIA

  def initialize
    @positions = {}
    @cities = MapCities.new
  end

  def prof_localized(evenment, professor)
    prof_loc = [professor.location]
    confidence = 4

    1.upto(evenment.to_s.match(/\d/)[0].to_i).each do
      prof_loc << @cities.random_city(professor.location)
      confidence -= 1
    end

    prof_loc.each do |loc|
      @positions[loc] = [@positions[loc], confidence].max
    end
  end

  # Give a target for the investigators
  def target_position
    max_confidence = @positions.values.max
    position = @positions.select {|key, value| value == max_confidence }.keys.sample
    position = @cities.random_city unless position
    position
  end

  # At the end of the turn
  # TODO : add the spread algo
  def confidence_lowered
    @positions.transform_values! {|value| value - 1}
    @positions.delete_if {|key, value| value == 0 }
  end

end