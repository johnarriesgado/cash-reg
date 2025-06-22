class Api::CartsController < ApplicationController
  def index
    carts = Cart.includes(cart_items: :product).all

    result = carts.map do |cart|
      items = cart.cart_items.flat_map { |item| [item.product.code] * item.quantity }
      total = OrderedItems.new(
        cart.cart_items.map { |item| { product: item.product, quantity: item.quantity } }
      ).process.last

      {
        id: cart.id,
        items: items,
        total: total
      }
    end

    render json: result
  end

  def create
    cart = Cart.create!
    render json: { id: cart.id }, status: :created
  end

  def show
    cart = Cart.includes(cart_items: :product).find_by(id: params[:id])

    return render json: { error: "Cart not found" }, status: :not_found unless cart

    items = cart.cart_items.map { |i| { product: i.product, quantity: i.quantity } }
    codes, total  = OrderedItems.new(items).process

    render json: { items: codes, total: total }
  end
end
