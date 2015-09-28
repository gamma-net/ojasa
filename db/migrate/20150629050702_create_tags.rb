class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :status_id
      t.string :tag_type
      t.integer :sort
      t.timestamps null: false
    end
  end
end
