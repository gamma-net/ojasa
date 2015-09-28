class CreateProductItems < ActiveRecord::Migration
  def change
    create_table :product_items do |t|
      t.belongs_to  :product
      t.string      :option
      t.string      :sku
      t.integer     :stock
      t.decimal     :price, precision: 15, scale: 2
      t.decimal     :sale_price, precision: 15, scale: 2
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
