class OrderServicesController < ApplicationController
  before_filter :update_cart!, only: [:order, :request_service]
  
  def order
    if params[:location].blank? || params[:category_id].blank?
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
      if order.validate? && order.save!
        # initialize_cart
        cart[:order_id] = order.id
        # flash[:success] = 'Thank you for your order'
        redirect_to confirm_order_services_url and return
      else
        if order.past_date?
          flash[:error] = "Please select a date today or sometime in the future"
        else
          flash[:error] = 'Please fill in all information below'
        end
        redirect_to :back and return
      end
    else
      flash[:error] = 'Please login first'
      redirect_to login_accounts_url and return
    end
  end
  
  def ac_service
    redirect_to location_order_services_url(service_type: 'ac_service') and return
  end

  def cleaning
    redirect_to location_order_services_url(service_type: 'cleaning') and return
  end

  def home_improvement
    # redirect_to location_order_services_url(service_type: 'home_improvement') and return
  end

  def gardener
    redirect_to location_order_services_url(service_type: 'gardener') and return
  end

  def auto_care
    redirect_to location_order_services_url(service_type: 'auto_care') and return
  end

  def massage
    redirect_to location_order_services_url(service_type: 'massage') and return
  end

  def beauty
    # redirect_to location_order_services_url(service_type: 'beauty') and return
  end

  def locksmith
    redirect_to location_order_services_url(service_type: 'locksmith') and return
  end

  def henna
    redirect_to location_order_services_url(service_type: 'henna') and return
  end
  
  def hijab
    redirect_to location_order_services_url(service_type: 'hijab') and return
  end

  def waxing
    redirect_to location_order_services_url(service_type: 'waxing') and return
  end

  def hairdo
    redirect_to location_order_services_url(service_type: 'hairdo') and return
  end
  
  def pest_control
    redirect_to location_order_services_url(service_type: 'pest_control') and return
  end
  
  def pool
    redirect_to location_order_services_url(service_type: 'pool') and return
  end
    
  protected 
    
    def order_params
      params[:order] ? params.require(:order).permit! : {}
    end
    
    def update_cart!
      session[:cart] ||= {}
      session[:cart]["location"] = params[:location] if params[:location]
      session[:cart]["category_id"] = params[:category_id] if params[:category_id]
      session[:cart]["service_type"] = params[:service_type] if params[:service_type]
      session[:cart].merge!(order_params) unless order_params.blank?
    end
    
end
