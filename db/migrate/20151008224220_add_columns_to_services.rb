class AddColumnsToServices < ActiveRecord::Migration
  def change
    add_column :services, :location, :string
    add_column :services, :days, :string
  end
end
