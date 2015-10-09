class OrderServicesController < ApplicationController

  def order
    if params[:location].empty? || params[:category_id].empty?
      flash[:error] = 'Please select our Services and Location'
      redirect_to order_services_url and return
    end
    
    unless Service.find_by_location_and_service(params[:location], params[:category_id])
      flash[:error] = "We are sorry, we don't have anyone available at the time"
      redirect_to order_services_url and return
    end
    
  end
  
  def request_service
    if logged_in?
      order = Order.new(order_params.merge(customer_id: session[:customer]['id'], status_id: Order.open))
      if !order.past_date? && order.save!
        flash[:success] = 'Thank you for your order'
        redirect_to order_services_url and return
      else
        flash[:error] = 'Please select correct date'
        redirect_to :back and return
      end
    else
      flash[:error] = 'Please login first'
      redirect_to login_accounts_url and return
    end
  end
  
  def clean
    render layout: nil
  end
  
  protected 
    
    def order_params
      params.require(:order).permit!
    end
    
end
