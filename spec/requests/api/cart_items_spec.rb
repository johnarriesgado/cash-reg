require 'rails_helper'

RSpec.describe "Api::CartItems", type: :request do
  let(:cart) { Cart.create! }
  let(:product) { create(:product, :green_tea) }

  describe "POST /api/carts/:cart_id/cart_items" do
    it "adds an item to the cart using product_code" do
      post api_cart_cart_items_path(cart_id: cart.id), params: {
        product_code: product.code,
        quantity: 2
      }

      expect(response).to have_http_status(:created)
      expect(cart.cart_items.count).to eq(1)
      expect(cart.cart_items.first.product).to eq(product)
    end

    it "returns 404 if product not found" do
      post api_cart_cart_items_path(cart_id: cart.id), params: {
        product_code: "INVALID",
        quantity: 1
      }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to have_key("error")
    end

    it "returns 404 if cart not found" do
      post api_cart_cart_items_path(cart_id: 99999), params: {
        product_code: product.code,
        quantity: 1
      }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 422 for invalid quantity" do
      post api_cart_cart_items_path(cart_id: cart.id), params: {
        product_code: product.code,
        quantity: 0
      }

      expect(response).to have_http_status(422)
    end
  end
end
