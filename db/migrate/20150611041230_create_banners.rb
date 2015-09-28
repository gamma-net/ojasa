class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string      :name
      t.string      :image_url
      t.string      :link_url
      t.integer     :sort
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :image
      t.timestamps  null: false
    end
  end
end
