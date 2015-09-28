class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string      :title
      t.string      :author
      t.date        :date
      t.string      :headline
      t.string      :keyword
      t.text        :article
      t.string      :link_url
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.timestamps  null: false
    end
  end
end
