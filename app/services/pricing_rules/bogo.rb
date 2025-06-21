module PricingRules
  class Bogo < Base
    def apply
      # CEO rule only applies for green tea
      return @items unless @product_code == "GR1"

      count = @items.count
      price = @items.first.price
      chargeable_count = (count / 2.0).ceil
      total = chargeable_count * price

      [{ code: @product_code, price: total.round(2) }]
    end
  end
end
