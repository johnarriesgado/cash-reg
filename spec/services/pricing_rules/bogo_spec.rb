require 'rails_helper'

RSpec.describe PricingRules::Bogo do
  let(:green_tea) { create(:product, :green_tea) }

  it 'applies BOGO rule to even quantity' do
    items = [green_tea, green_tea, green_tea, green_tea]
    rule = described_class.new('GR1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(6.22)
  end

  it 'applies BOGO rule to odd quantity' do
    items = [green_tea, green_tea, green_tea]
    rule = described_class.new('GR1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(6.22)
  end

  it 'charges full price for 1 item' do
    items = [green_tea]
    rule = described_class.new('GR1', items)
    result = rule.apply

    expect(result.first[:price]).to eq(3.11)
  end
end
