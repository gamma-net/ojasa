class FeedbackController < ApplicationController
  layout 'mailer'
  
  def index
    @order = Order.find(params[:order_id])
    if Feedback.where(order_id: @order.id).first
      flash[:error] = "You cannot give feedback more than once"
      redirect_to order_services_url and return
    end
  end
  
  def rate
    @order = Order.find(params[:order_id])
    @order.feedback!(feedback_params)
    flash[:success] = "Thank you for your feedback"
    redirect_to order_services_url and return
  end
  
  protected
  
    def feedback_params
      params.require(:feedback).permit!
    end
  
end
