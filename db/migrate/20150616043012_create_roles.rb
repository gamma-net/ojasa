class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string      :name
      t.integer     :sort
      t.string      :permissions
      t.timestamps  null: false
    end
  end
end
