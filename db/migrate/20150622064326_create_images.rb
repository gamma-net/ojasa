class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer     :sort
      t.integer     :content_id
      t.string      :content_type
      t.attachment  :image
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
