class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :orders, :detail, :string
    add_column :orders, :requested_at, :datetime
  end
end
