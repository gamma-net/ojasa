class PaymentsController < ApplicationController
  layout 'order_services'

  before_filter :validate_login

  def index
    @order = Order.where(id: params[:order_id], customer_id: session[:customer]['id']).first
    unless @order
      flash[:error] = 'We are sorry, we cannot find your order at the moment'
      redirect_to order_services_url and return
    end
    redirect_to receipt_order_services_url(order_id: @order.id) and return unless @order.pending_payment?
  end
  
  def process_payment
    order = Order.find(cart["order_id"])
    order.pay!
    redirect_to thanks_payments_url
  end
end
