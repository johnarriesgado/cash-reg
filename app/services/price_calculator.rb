class PriceCalculator
  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = pricing_rules
  end

  def add(product)
    @items << product
  end

  def total
    grouped = @items.group_by(&:code)

    rule_classes = {
      "GR1" => PricingRules::Bogo,
      "SR1" => PricingRules::BulkDiscount,
      "CF1" => PricingRules::PriceDrop
    }

    discounted_items = grouped.flat_map do |code, items|
      rule_class = rule_classes[code]
      if rule_class
        rule_class.new(code, items).apply
      else
        items.map { |item| { code: item.code, price: item.price } }
      end
    end

    discounted_items.sum { |item| item[:price] }.round(2)
  end
end
