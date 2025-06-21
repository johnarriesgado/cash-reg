require 'rails_helper'

RSpec.describe PricingRules::BulkDiscount do
  let(:strawberries) { create(:product, :strawberries) }

  it 'applies discount when quantity >= 3' do
    items = [strawberries, strawberries, strawberries]
    rule = described_class.new('SR1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(13.50)
  end

  it 'does not apply discount when quantity < 3' do
    items = [strawberries, strawberries]
    rule = described_class.new('SR1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(10.00)
  end
end
