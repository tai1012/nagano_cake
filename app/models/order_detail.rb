class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item, optional: true
end
