class Ride

  attr_reader :name, 
              :min_height, 
              :admission_fee, 
              :excitement, 
              :total_revenue,
              :rider_log

  def initialize(data)
      @name = data[:name] 
      @min_height = data[:min_height] 
      @admission_fee = data[:admission_fee] 
      @excitement = data[:excitement] 
      @total_revenue ||= 0 
      @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if visitor.tall_enough?(@min_height) && (visitor.spending_money >= @admission_fee) && visitor.preferences.include?(@excitement)
      @rider_log[visitor] += 1
      @total_revenue += @admission_fee
      visitor.spending_money -= @admission_fee
    end
  end
end