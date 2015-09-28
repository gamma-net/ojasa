class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string      :title
      t.string      :description
      t.string      :photographer
      t.date        :date_taken
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
