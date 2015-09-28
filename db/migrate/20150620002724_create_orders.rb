class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to  :customer
      t.integer     :status_id
      t.decimal     :subtotal, precision: 15, scale: 2
      t.decimal     :tax, precision: 15, scale: 2
      t.decimal     :shipping, precision: 15, scale: 2
      t.decimal     :discount, precision: 15, scale: 2
      t.decimal     :total, precision: 15, scale: 2
      t.integer     :shipping_address_id
      t.integer     :billing_address_id
      t.integer     :service_id
      t.integer     :service_period
      t.timestamps  null: false
    end
  end
end
