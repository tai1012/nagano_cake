class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
end
