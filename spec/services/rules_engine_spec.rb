require 'rails_helper'

RSpec.describe RulesEngine do
  it "returns the correct rule for GR1" do
    expect(RulesEngine.for("GR1")).to eq(PricingRules::Bogo)
  end

  it "returns nil for unknown code" do
    expect(RulesEngine.for("UNKNOWN")).to be_nil
  end
end
