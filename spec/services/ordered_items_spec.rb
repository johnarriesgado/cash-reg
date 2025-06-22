require 'rails_helper'

RSpec.describe OrderedItems do
  let(:green_tea) { create(:product, :green_tea) }
  let(:strawberries) { create(:product, :strawberries) }
  let(:coffee) { create(:product, :coffee) }

  def wrap(product, quantity = 1)
    { product:, quantity: }
  end

  it 'calculates total for GR1, SR1, GR1, GR1, CF1' do
    items = [
      wrap(green_tea, 3),
      wrap(strawberries, 1),
      wrap(coffee, 1)
    ]
    codes, total = OrderedItems.new(items).process

    expect(codes).to eq(["GR1", "GR1", "GR1", "SR1", "CF1"])
    expect(total).to eq(22.45)
  end

  it 'calculates total for GR1, GR1' do
    items = [wrap(green_tea, 2)]
    _, total = OrderedItems.new(items).process

    expect(total).to eq(3.11)
  end

  it 'calculates total for SR1, SR1, GR1, SR1' do
    items = [
      wrap(strawberries, 3),
      wrap(green_tea, 1)
    ]
    _, total = OrderedItems.new(items).process

    expect(total).to eq(16.61)
  end

  it 'calculates total for GR1, CF1, SR1, CF1, CF1' do
    items = [
      wrap(green_tea, 1),
      wrap(coffee, 3),
      wrap(strawberries, 1)
    ]
    _, total = OrderedItems.new(items).process

    expect(total).to eq(30.57)
  end
end
