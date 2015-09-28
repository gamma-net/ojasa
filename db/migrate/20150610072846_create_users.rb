class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :email
      t.string      :first_name
      t.string      :last_name
      t.string      :username
      t.string      :password
      t.integer     :role_id
      t.timestamps  null: false
    end
  end
end
