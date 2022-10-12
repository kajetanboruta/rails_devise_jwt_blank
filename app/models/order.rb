class Order < ApplicationRecord
  enum status: [:pending, :closed]

  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
end
