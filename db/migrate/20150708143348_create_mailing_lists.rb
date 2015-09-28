class CreateMailingLists < ActiveRecord::Migration
  def change
    create_table :mailing_lists do |t|
      t.string      :email
      t.string      :full_name
      t.date        :birthdate
      t.string      :gender
      t.string      :mobile
      t.string      :street1
      t.string      :street2
      t.string      :city
      t.string      :region
      t.string      :postal_code
      t.string      :country
      t.text        :feedback
      t.string      :bounce
      t.string      :unsubscribe
      t.datetime    :confirmed_at
      t.timestamps  null: false
    end
  end
end
