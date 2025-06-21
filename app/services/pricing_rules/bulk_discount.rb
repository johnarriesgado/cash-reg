module PricingRules
  class BulkDiscount < Base
    def apply
      # COO rule only applies to Strawberries
      return @items unless @product_code == "SR1"

      discounted_price = @items.count >= 3 ? 4.50 : @items.first.price
      total = (@items.count * discounted_price).round(2)

      [{ code: @product_code, price: total }]
    end
  end
end
