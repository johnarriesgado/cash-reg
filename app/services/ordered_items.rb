class OrderedItems
  def initialize(items = [])
    @items = items
  end

  def process
    products = @items.flat_map { |item| Array.new(item[:quantity], item[:product]) }

    grouped = products.group_by(&:code)

    discounted_items = grouped.flat_map do |code, group|
      rule_class = RulesEngine.for(code)

      if rule_class
        rule_class.new(code, group).apply
      else
        group.map { |product| { code: product.code, price: product.price } }
      end
    end

    codes = products.map(&:code)
    total = discounted_items.sum { |item| item[:price] }.round(2)

    [codes, total]
  end
end
