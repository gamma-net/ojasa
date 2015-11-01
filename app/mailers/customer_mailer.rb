class CustomerMailer < ApplicationMailer
  
  def order_email(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "Thank you for your Order (#{@order.id})")
  end

  def payment_received(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "Payment Received (#{@order.id})")
  end
end
