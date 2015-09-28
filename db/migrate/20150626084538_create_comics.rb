class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string      :name
      t.text        :description
      t.belongs_to  :category
      t.integer     :sort
      t.attachment  :image
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps null: false
    end
  end
end
