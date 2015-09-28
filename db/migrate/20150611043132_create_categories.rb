class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :name
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :image
      t.timestamps  null: false
    end
  end
end
