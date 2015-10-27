class AddRequestedDateTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :requested_date, :date
    add_column :orders, :requested_time, :string
  end
end
