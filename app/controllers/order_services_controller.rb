class OrderServicesController < ApplicationController

  def request_service
    if logged_in?
      if Order.create(order_params.merge(customer_id: session[:customer]['id'], status_id: Order.open))
        flash[:success] = 'Thank you for your order'
        redirect_to order_services_url and return
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
