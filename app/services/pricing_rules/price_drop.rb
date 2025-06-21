module PricingRules
  class PriceDrop < Base
    def apply
      # VP rule only applies to Coffee
      return @items unless @product_code == "CF1"

      price = @items.first.price
      discounted_price = @items.count >= 3 ? price * 2/3r : price
      total = (@items.count * discounted_price).round(2)

      [{ code: @product_code, price: total }]
    end
  end
end
