class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to  :order
      t.belongs_to  :product_item
      t.decimal     :sold_price, precision: 15, scale: 2
      t.decimal     :original_price, precision: 15, scale: 2
      t.integer     :quantity
      t.timestamps  null: false
    end
  end
end
