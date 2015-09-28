class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string      :name
      t.string      :metadata
      t.string      :description
      t.integer     :sort
      t.string      :base_sku
      t.decimal     :base_price, precision: 15, scale: 2
      t.decimal     :sale_price, precision: 15, scale: 2
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :image
      t.timestamps  null: false
    end
  end
end
