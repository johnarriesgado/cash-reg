require 'rails_helper'

RSpec.describe PricingRules::PriceDrop do
  let(:coffee) { create(:product, :coffee) }

  it 'applies 2/3 price when quantity >= 3' do
    items = [coffee, coffee, coffee]
    rule = described_class.new('CF1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(22.46)
  end

  it 'charges full price when quantity < 3' do
    items = [coffee, coffee]
    rule = described_class.new('CF1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(22.46)
  end
end
