class Item < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, dependent: :destroy

  attachment :image

  def taxed_price
    (price * 1.1).round
  end
end
