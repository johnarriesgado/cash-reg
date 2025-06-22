module RulesEngine
  RULE_MAP = {
    %w[GR1] => PricingRules::Bogo,
    %w[SR1] => PricingRules::BulkDiscount,
    %w[CF1] => PricingRules::PriceDrop
  }.freeze

  def self.for(code)
    RULE_MAP.each do |codes, klass|
      return klass if codes.include?(code)
    end
    nil
  end
end
