require 'spec_helper'

RSpec.describe Visitor do
  before do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    #=> #<Visitor:0x000000012f2b2818 @height=54, @name="Bruce", @preferences=[], @spending_money=10>
    
    @visitor2 = Visitor.new('Tucker', 36, '$5')

    @visitor3 = Visitor.new('Penny', 64, '$15')
#=> #<Visitor:0x000000012f176760 @height=64, @name="Penny", @preferences=[], @spending_money=15>

  end

  it 'exists' do
    expect(@visitor1).to be_a(Visitor)
  end

  it 'has readable attributes' do
    expect(@visitor1.name).to eq("Bruce")
    expect(@visitor1.height).to eq(54)
    expect(@visitor1.spending_money).to eq(10)
    expect(@visitor1.preferences).to eq([])
  end

  it 'can #add_preference' do
    @visitor1.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)
    expect(@visitor1.preferences).to eq([:gentle, :thrilling])
  end

  it '#tall_enough' do
    expect(@visitor1.tall_enough?(54)).to be true
    expect(@visitor2.tall_enough?(54)).to be false
    expect(@visitor3.tall_enough?(54)).to be true
    expect(@visitor1.tall_enough?(64)).to be false
  end
end


