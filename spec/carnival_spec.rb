require 'spec_helper'

RSpec.describe Carnival do
  before do
    @carnival1 = Carnival.new("15 days")
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')

  end

  it 'exists' do
    expect(@carnival1).to be_a(Carnival)
  end

  it 'has readable attributes' do
    expect(@carnival1.duration).to eq("15 days")
    expect(@carnival1.rides).to eq([])
  end

  it 'can #add_rides' do
    expect(@carnival1.rides).to eq([])

    @carnival1.add_ride(@ride1)
    @carnival1.add_ride(@ride2)
    @carnival1.add_ride(@ride3)

    expect(@carnival1.rides).to eq([@ride1, @ride2, @ride3])
  end

  it '#most_popular_ride' do
    @visitor1.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
    @visitor3.add_preference(:gentle)

    @carnival1.add_ride(@ride1) 
    @carnival1.add_ride(@ride2)
    @carnival1.add_ride(@ride3)

    @ride1.board_rider(@visitor1)
    @ride1.board_rider(@visitor2)
    @ride1.board_rider(@visitor1)

    expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    
    @ride1.board_rider(@visitor2)
    @ride2.board_rider(@visitor3)
    @ride3.board_rider(@visitor3)
    @ride3.board_rider(@visitor1)
    @ride3.board_rider(@visitor2)
    @ride3.board_rider(@visitor3)

    expect(@ride1.rider_log).to eq(@visitor1 => 2, @visitor2 => 2)
    expect(@ride2.rider_log).to eq({@visitor3 => 1})
    expect(@ride3.rider_log).to eq({@visitor1 => 1, @visitor3 => 2})

    expect(@carnival1.most_popular_ride).to eq(@ride3)
  end
end