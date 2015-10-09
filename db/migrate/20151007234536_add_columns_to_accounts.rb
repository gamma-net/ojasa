class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :customers, :full_name, :string
    add_column :customers, :address, :string
    add_column :customers, :addressdetail, :string
    add_column :customers, :phone, :string
  end
end
