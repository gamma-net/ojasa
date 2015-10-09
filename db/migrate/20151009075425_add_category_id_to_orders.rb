class AddCategoryIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :category_id, :integer
  end
end
