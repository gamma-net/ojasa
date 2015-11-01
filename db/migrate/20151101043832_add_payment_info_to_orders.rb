class AddPaymentInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status_code, :string
    add_column :orders, :status_message, :string
    add_column :orders, :payment_type, :string
    add_column :orders, :transaction_id, :string
    add_column :orders, :transaction_time, :string
    add_column :orders, :transaction_status, :string
    add_column :orders, :fraud_status, :string
    add_column :orders, :approval_code, :string
    add_column :orders, :masked_card, :string
    add_column :orders, :veritrans_order_id, :string
    add_column :orders, :bank, :string
  end
end
