class Api::CartItemsController < ApplicationController
  def create
    cart = Cart.find_by(id: params[:cart_id])
    return render json: { error: "Cart not found" }, status: :not_found unless cart

    product = Product.find_by(id: params[:product_id])
    return render json: { error: "Product not found" }, status: :not_found unless product

    quantity = params[:quantity].to_i

    cart_item = cart.cart_items.create!(product:, quantity:)
    render json: cart_item, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages.join(", ") }, status: :unprocessable_entity
  end
end
