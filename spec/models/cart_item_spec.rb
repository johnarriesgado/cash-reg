require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "is valid with a product and quantity" do
    cart_item = build(:cart_item)
    expect(cart_item).to be_valid
  end

  it "is invalid without a product" do
    cart_item = build(:cart_item, product: nil)
    expect(cart_item).not_to be_valid
  end

  it "is invalid without a cart" do
    cart_item = build(:cart_item, cart: nil)
    expect(cart_item).not_to be_valid
  end

  it "is invalid with a quantity less than 1" do
    cart_item = build(:cart_item, quantity: 0)
    expect(cart_item).not_to be_valid
  end
end
