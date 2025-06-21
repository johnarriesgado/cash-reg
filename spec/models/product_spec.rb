require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "is invalid without a code" do
    product = build(:product, code: nil)
    expect(product).not_to be_valid
  end

  it "is invalid without a name" do
    product = build(:product, name: nil)
    expect(product).not_to be_valid
  end

  it "is invalid without a price" do
    product = build(:product, price: nil)
    expect(product).not_to be_valid
  end
end
