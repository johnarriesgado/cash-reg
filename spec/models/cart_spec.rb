require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "can be created" do
    cart = create(:cart)
    expect(cart).to be_valid
  end

  it "can have many cart items" do
    cart = create(:cart)
    product = create(:product)
    cart.cart_items.create!(product:, quantity: 2)

    expect(cart.cart_items.count).to eq(1)
    expect(cart.cart_items.first.product).to eq(product)
  end
end
