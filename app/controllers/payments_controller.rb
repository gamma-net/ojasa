class PaymentsController < ApplicationController
  layout 'order_services'
  
  def process_payment
    order = Order.find(cart["order_id"])
    order.pay!
    redirect_to thanks_payments_url
  end
end
