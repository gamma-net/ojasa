class AdminMailer < ApplicationMailer
  def work_request_email(order)
    @order = order
    @warrior = @order.customer
    
    # mail(to: 'order@ojasa.co.id', subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] Thank you for your order")
  end
  
  def notify_support(order, subject_suffix="New Order")
    @order = order
    @warrior = @order.customer
    
    mail(to: 'order@ojasa.co.id', subject: "[#{ApplicationController::SITE_NAME} #{@order.id}] #{subject_suffix}")
  end
end
