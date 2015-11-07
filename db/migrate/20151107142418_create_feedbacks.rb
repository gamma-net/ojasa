class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer     :order_id
      t.integer     :service_id
      t.integer     :rating
      t.text        :comment
      t.timestamps  null: false
    end
  end
end
