class OrderServicesController < ApplicationController
  before_filter :update_cart!, only: [:order, :request_service]
  
  def order
    if params[:location].blank? || params[:category_id].blank?
      error_message = 'Please select our '
      error_msg_array ||= []
      error_msg_array << 'Service' if params[:category_id].blank?
      error_msg_array << 'Location' if params[:location].blank? 
      flash[:error] = error_message + error_msg_array.join(' and ')
      redirect_to :back and return
    end
    
    unless Service.find_by_location_and_service(params[:location], params[:category_id])
      flash[:error] = "We are sorry, we don't have anyone available at the time"
      redirect_to :back and return
    end
  end
  
  def request_service
    if logged_in?
      order = Order.new(order_params.merge(customer_id: session[:customer]['id'], status_id: Order.open))
      if order.validate? && order.save!
        session[:cart]["order_id"] = order.id
        redirect_to confirm_order_services_url and return
      else
        if order.past_date?
          flash[:error] = "Please select a date today or sometime in the future"
        else
          flash[:error] = 'Please fill in all information below'
        end
        redirect_to type_order_services_url and return
      end
    else
      flash[:error] = 'Please login first'
      redirect_to login_accounts_url and return
    end
  end
  
  def request_payment
    if logged_in?
      order = Order.find(session[:cart]["order_id"])
      order.status_id = Order.pending_payment
      if order.validate? && order.save!
        initialize_cart
        flash[:success] = 'Thank you for your order'
        redirect_to thanks_order_services_url and return
      else
        if order.past_date?
          flash[:error] = "Please select a date today or sometime in the future"
        else
          flash[:error] = 'Please fill in all information below'
        end
        redirect_to type_order_services_url and return
      end
    else
      flash[:error] = 'Please login first'
      redirect_to login_accounts_url and return
    end
  end
  
  def ac_service
    url_params = if (category = Category.find_tag_name('ac_service'))
                  {:category_id => category.id}
                else
                  {:service_type => 'ac_service'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def cleaning
    url_params = if (category = Category.find_tag_name('cleaning'))
                  {:category_id => category.id}
                else
                  {:service_type => 'cleaning'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def home_improvement
    # url_params = if  (category = Category.find_tag_name('home_improvement'))
    #               {:category_id => category.id}
    #             else
    #               {:service_type => 'home_improvement'}
    #             end
    # redirect_to location_order_services_url(url_params) and return
  end

  def gardener
    url_params = if (category = Category.find_tag_name('gardener'))
                  {:category_id => category.id}
                else
                  {:service_type => 'gardener'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def auto_care
    url_params = if (category = Category.find_tag_name('auto_care'))
                  {:category_id => category.id}
                else
                  {:service_type => 'auto_care'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def massage
    url_params = if (category = Category.find_tag_name('massage'))
                  {:category_id => category.id}
                else
                  {:service_type => 'massage'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def beauty
    # url_params = if (category = Category.find_tag_name('beauty'))
    #               {:category_id => category.id}
    #             else
    #               {:service_type => 'beauty'}
    #             end
    # redirect_to location_order_services_url(url_params) and return
  end

  def locksmith
    url_params = if (category = Category.find_tag_name('locksmith'))
                  {:category_id => category.id}
                else
                  {:service_type => 'locksmith'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def henna
    url_params = if (category = Category.find_tag_name('henna'))
                  {:category_id => category.id}
                else
                  {:service_type => 'henna'}
                end
    redirect_to location_order_services_url(url_params) and return
  end
  
  def hijab
    url_params = if (category = Category.find_tag_name('hijab'))
                  {:category_id => category.id}
                else
                  {:service_type => 'hijab'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def waxing
    url_params = if (category = Category.find_tag_name('waxing'))
                  {:category_id => category.id}
                else
                  {:service_type => 'waxing'}
                end
    redirect_to location_order_services_url(url_params) and return
  end

  def hairdo
    url_params = if (category = Category.find_tag_name('hairdo'))
                  {:category_id => category.id}
                else
                  {:service_type => 'hairdo'}
                end
    redirect_to location_order_services_url(url_params) and return
  end
  
  def pest_control
    url_params = if (category = Category.find_tag_name('pest_control'))
                  {:category_id => category.id}
                else
                  {:service_type => 'pest_control'}
                end
    redirect_to location_order_services_url(url_params) and return
  end
  
  def pool
    url_params = if (category = Category.find_tag_name('pool'))
                  {:category_id => category.id}
                else
                  {:service_type => 'pool'}
                end
    redirect_to location_order_services_url(url_params) and return
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
