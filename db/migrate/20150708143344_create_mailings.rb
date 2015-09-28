class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.string      :subject
      t.text        :body_plain
      t.text        :body_html
      t.string      :preview_recipients
      t.integer     :type_id
      t.datetime    :scheduled_at
      t.datetime    :sent_at
      t.integer     :recipients_count
      t.boolean     :draft
      t.boolean     :sending
      t.timestamps  null: false
    end
  end
end
