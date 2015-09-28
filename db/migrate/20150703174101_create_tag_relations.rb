class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.integer     :content_id
      t.string      :content_type
      t.integer     :tag_id  
      t.timestamps  null: false
    end
  end
end
