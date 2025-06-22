require 'rails_helper'

RSpec.describe "Api::CartItems", type: :request do
  let(:cart) { Cart.create! }
  let(:product) { create(:product, :green_tea) }

  describe "POST /api/carts/:cart_id/cart_items" do
    context "with valid parameters" do
      it "adds an item to the cart" do
        post api_cart_cart_items_path(cart_id: cart.id), params: {
          product_id: product.id,
          quantity: 2
        }

        expect(response).to have_http_status(:created)
        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.product).to eq(product)
        expect(cart.cart_items.first.quantity).to eq(2)
      end
    end

    context "when the cart does not exist" do
      it "returns 404 not found" do
        post api_cart_cart_items_path(cart_id: 999), params: {
          product_id: product.id,
          quantity: 1
        }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include("error" => "Cart not found")
      end
    end

    context "when the product does not exist" do
      it "returns 404 not found" do
        post api_cart_cart_items_path(cart_id: cart.id), params: {
          product_id: 999,
          quantity: 1
        }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include("error" => "Product not found")
      end
    end

    context "when the quantity is invalid" do
      it "returns 422 unprocessable entity" do
        post api_cart_cart_items_path(cart_id: cart.id), params: {
          product_id: product.id,
          quantity: 0
        }

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["error"]).to include("Quantity must be greater than 0")
      end
    end
  end
end
