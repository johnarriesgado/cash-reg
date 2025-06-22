# 🧾 Cash Register API

A minimalist Ruby on Rails API that simulates a cash register with flexible pricing rules. Designed for backend-first development, this service supports discount schemes like BOGO, bulk pricing, and price drops. Perfect for integration with a React or any frontend client.

---

## ✨ Features

- 🛒 Create carts and add items to them
- 💸 Apply custom pricing rules:
  - **BOGO (Buy-One-Get-One-Free)** – e.g. for Green Tea
  - **Bulk Discount** – e.g. price drop after 3+ items
  - **Price Drop** – e.g. 2/3 of original price if quantity ≥ 3
- ⚙️ Clean service-based architecture (`OrderedItems`, `PricingRules::*`)
- ✅ API is covered by RSpec tests (~90%+ coverage)
- 🐳 Deployable with Docker (including to Vercel)
- 🔄 Future-proof rule engine for scalable discounting logic

---

## 🧱 Tech Stack

- **Ruby on Rails 7+**
- **PostgreSQL** (production)
- **SQLite3** (development/local)
- **RSpec** for testing
- **Vercel** (optional Docker deployment)
- **FactoryBot** for test data

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/cash-reg.git
cd cash-reg
```

### 2. Install dependencies
`bundle install`

### 3. Setup DB
`rails db:create db:migrate db:seed`

### 4. Start Server
`rails s`


## 🧪 API Endpoint

### 🛒 Cart

Get Cart and Total
`GET /api/carts/:id`
Response
```
{
  "items": ["GR1", "CF1", "CF1"],
  "total": 22.45
}
```

➕ Add Product to Cart
`POST /api/carts/:cart_id/cart_items`
Body
```
{
  "product_id": 1,
  "quantity": 2
}
```
Response
```
{
  "id": 3,
  "cart_id": 1,
  "product_id": 1,
  "quantity": 2
}
```

## 🧠 Pricing Rules Engine

Pricing rules are defined in app/services/pricing_rules/.
Each rule class implements apply and can be mapped to multiple products using:

```
RULE_MAP = {
  %w[GR1] => PricingRules::Bogo,
  %w[SR1] => PricingRules::BulkDiscount,
  %w[CF1] => PricingRules::PriceDrop
}
```
Used by the OrderedItems service to calculate total and product breakdown.

📄 TODO
User Authentication
CMS for managing products
Extend rule engine to use DB or JSON config or third party engine.