class AddSelectAddressToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :select_address, :integer
  end
end
