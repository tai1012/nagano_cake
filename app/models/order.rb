class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_details
end
