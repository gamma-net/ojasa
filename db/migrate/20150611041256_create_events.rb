class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string      :title
      t.date        :date
      t.string      :venues
      t.text        :description
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
