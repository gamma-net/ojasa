class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string      :name
      t.belongs_to  :category
      t.string      :contact_number
      t.text        :description
      t.string      :keyword
      t.integer     :address_id
      t.decimal     :fee, precision: 15, scale: 2
      t.integer     :fee_type_id
      t.integer     :sort
      t.time        :open_time
      t.time        :close_time
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
