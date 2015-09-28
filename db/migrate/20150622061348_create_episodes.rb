class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string      :name
      t.text        :details
      t.belongs_to  :comic
      t.integer     :sort
      t.attachment  :image
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
