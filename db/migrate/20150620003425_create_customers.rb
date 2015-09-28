class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string      :email
      t.string      :first_name
      t.string      :last_name
      t.string      :username
      t.string      :password
      t.string      :gender
      t.date        :birthdate
      t.integer     :address_id
      t.timestamps  null: false
    end
  end
end
