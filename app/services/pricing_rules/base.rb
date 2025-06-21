module PricingRules
  class Base
    def initialize(product_code, items)
      @product_code = product_code
      @items = items
    end

    def apply
      raise NotImplementedError, "Subclasses must implement `apply`"
    end
  end
end
