require 'rails_helper'

RSpec.describe PriceCalculator do
  let(:green_tea) { create(:product, :green_tea) }
  let(:strawberries) { create(:product, :strawberries) }
  let(:coffee) { create(:product, :coffee) }

  it 'calculates total for GR1, SR1, GR1, GR1, CF1' do
    items = PriceCalculator.new
    items.add(green_tea)
    items.add(strawberries)
    items.add(green_tea)
    items.add(green_tea)
    items.add(coffee)

    expect(items.total).to eq(22.45)
  end

  it 'calculates total for GR1, GR1' do
    items = PriceCalculator.new
    items.add(green_tea)
    items.add(green_tea)

    expect(items.total).to eq(3.11)
  end

  it 'calculates total for SR1, SR1, GR1, SR1' do
    items = PriceCalculator.new
    items.add(strawberries)
    items.add(strawberries)
    items.add(green_tea)
    items.add(strawberries)

    expect(items.total).to eq(16.61)
  end

  it 'calculates total for GR1, CF1, SR1, CF1, CF1' do
    items = PriceCalculator.new
    items.add(green_tea)
    items.add(coffee)
    items.add(strawberries)
    items.add(coffee)
    items.add(coffee)

    expect(items.total).to eq(30.57)
  end
end
