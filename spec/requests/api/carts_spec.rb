# spec/requests/api/carts_spec.rb

RSpec.describe "Api::Carts", type: :request do
  let(:cart) { Cart.create! }

  describe "POST /api/carts" do
    it "creates a new cart" do
      post api_carts_path
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json).to have_key("id")
      expect(Cart.find_by(id: json["id"])).to be_present
    end
  end

  describe "GET /api/carts/:id" do
    it "shows the cart" do
      get api_cart_path(cart)
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body).to include("items", "total")
    end
  end
end
