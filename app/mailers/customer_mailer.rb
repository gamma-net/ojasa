class CustomerMailer < ApplicationMailer
  layout false, only: [:feedback_request_email, :forgot_password_request, :order_email, :payment_received]
  
  def order_email(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] Thank you for your order")
  end

  def payment_received(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] Payment Received")
  end
  
  def warrior_info_email(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] Our warrior will be there soon")
  end
  
  def feedback_request_email(order)
    @order = order
    @customer = @order.customer
    
    mail(to: @customer.email, subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] Please share your feedback ")
  end
  
  def forgot_password_request(email)
    @email = email
    mail(to: @email, subject: "[#{ApplicationController::SITE_NAME}] Reset password request")
  end    
  
end
