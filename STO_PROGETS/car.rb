class Car 
attr_reader :number, :mark, :model, :kilometers 
def initialize(number, mark, model, kilometers, oil_last_changes, last_outside_filter_changes, last_inside_filter_changes, last_brake_changes, cooling_last_changes)
    @number = number
    @mark = mark
    @model = model
    @kilometers = kilometers
    @oil_last_changes = oil_last_changes
    @last_outside_filter_changes = last_outside_filter_changes
    @last_inside_filter_changes = last_inside_filter_changes
    @last_brake_changes = last_brake_changes
    @cooling_last_changes = cooling_last_changes

@oil_life = 8000
@brake_life = 30000
@air_outside_filter_life =10000
@air_inside_filter_life =15000
@cooling_liquid_life = 60000

end 


def calculate_oil_left
    passed_o = @kilometers - @oil_last_changes
    left_o = @oil_life - passed_o
    return left_o
  end

  def calculate_brake_left
    passed_b = @kilometers - @last_brake_changes
    left_b = @brake_life - passed_b
    return left_b
end 

def calculate_outside_filter_left
    passed_u = @kilometers - @last_outside_filter_changes
    left_u = @air_outside_filter_life - passed_u
    return left_u
end
def calculate_inside_filter_left
    passed_i = @kilometers - @last_inside_filter_changes
    left_i = @air_inside_filter_life - passed_i
    return left_i
end
def calculate_cooling_liqvid_left
    passed_c = @kilometers - @cooling_last_changes
    left_c = @cooling_liquid_life - passed_c
    return left_c
end
end