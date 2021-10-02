class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :payment_method, null: false, default: 0
      t.string :postal_code
      t.string :address
      t,string :name
      t.integer :shipping_fee
      t.integer :total_payment
      t.integer :order_status, null: false, default: 0

      t.timestamps
    end
  end
end
