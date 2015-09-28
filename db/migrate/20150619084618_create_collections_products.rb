class CreateCollectionsProducts < ActiveRecord::Migration
  def change
    create_table :collections_products do |t|
      t.belongs_to :collection, index: true
      t.belongs_to :product, index: true
    end
  end
end
