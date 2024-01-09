require 'spec_helper'

RSpec.describe Ride do
  before do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    #=> #<Ride:0x000000015a136ab8 @admission_fee=1, @excitement=:gentle, @min_height=24, @name="Carousel", @rider_log={}>
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    #<Ride:0x0000000159a0cd00 @admission_fee=5, @excitement=:gentle, @min_height=36, @name="Ferris Wheel", @rider_log={}>
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    #=> #<Ride:0x0000000159ae7a68 @admission_fee=2, @excitement=:thrilling, @min_height=54, @name="Roller Coaster", @rider_log={}>

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    #=> #<Visitor:0x000000015a16e918 @height=54, @name="Bruce", @preferences=[], @spending_money=10>
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    #=> #<Visitor:0x000000015a11c5c8 @height=36, @name="Tucker", @preferences=[], @spending_money=5>
    @visitor3 = Visitor.new('Penny', 64, '$15')
    #=> #<@Visitor:0x0000000159a852a0 @height=64, @name="Penny", @preferences=[], @spending_money=15
  end

  it 'exists' do
    expect(@ride1).to be_a(Ride)
  end

  it 'has readable attributes' do
    expect(@ride1.name).to eq("Carousel")
    expect(@ride1.min_height).to eq(24)
    expect(@ride1.admission_fee).to eq(1)
    expect(@ride1.excitement).to eq(:gentle)
    expect(@ride1.total_revenue).to eq(0)
  end

  describe '#board_rider' do
    it '#board_rider based on visitor.preference' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({visitor1 => 1, @visitor2 => 1})

    end

    it "adds to #total_revenue" do
    @ride1.board_rider(@visitor1)
    @ride1.board_rider(@visitor2)
    @ride1.board_rider(@visitor1)
    
    expect(@visitor1.spending_money).to eq(8)
    expect(@visitor2.spending_money).to eq(4)
    
    expect(@ride1.total_revenue).to eq(3)
    end
  end
end

# 2. Rides have a rider log that tracks who has ridden the ride and how many times

# 3. A rider's spending money is reduced by the admission fee when they board a ride

# 4. A rider does not board if they are not tall enough or do not have a matching preference for the ride's excitement level or do not have enough spending money left. 

# 5. A ride can calculate the total revenue it has earned


# expect(@visitor2.add_preference(:thrilling)).to eq([:gentle, :thrilling])

# expect(@visitor3.add_preference(:thrilling)).to eq()
# #=> [:thr])

# @ride3.board_rider(@visitor1)
# @ride3.board_rider(@visitor2)
# @ride3.board_rider(@visitor3)

# expect(@visitor1.spending_money).to eq(8)
# expect(@visitor2.spending_money).to eq(4)
# expect(@visitor3.spending_money).to eq(13)

# expect(@ride3.rider_log).to eq()
# #=> {#<@Visitor:0x00000852a0 @height=64, @name="Penny", @preferences=[:thrilling], )@spending_money=13> => 1}

# expect(@ride3.total_revenue).to eq(2)