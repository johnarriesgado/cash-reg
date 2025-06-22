class Api::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products.as_json(only: [:id, :code, :name, :price])
  end
end