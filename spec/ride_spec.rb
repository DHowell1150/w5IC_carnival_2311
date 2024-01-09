require 'spec_helper'

RSpec.describe Ride do
  before do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')

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
    it 'if visitor.attributes matching ride, #ride_log reflects boarding' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})

      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log).to eq({@visitor3 => 1})
 
    end

    it "adds to #total_revenue" do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      expect(@ride1.total_revenue).to eq(3)

      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      expect(@ride3.total_revenue).to eq(2)

    end
    
    it 'deducts admission_fee from visitor.spending_money' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      
      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)

      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
      expect(@visitor3.spending_money).to eq(13)
    end
  end
end