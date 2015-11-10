class AccountsController < ApplicationController  
  layout 'order_services'
  
  before_filter :validate_logged_in, only: [:logout]
  before_filter :validate_logged_out, except: [:logout]
  
  def logout
    clear_session
    redirect_to '/'
  end

  def signup
    @customer = Customer.new
  end
  
  def register
    @customer = Customer.new(customer_params)
    if @customer.save
      initialize_session(@customer)
      flash[:success] = 'Login success!'
      redirect_to redirect_to_url and return
    else
      @errors = @customer.errors
      flash[:error] = "Please fill up all information below and try again"
      render 'signup' and return
    end
    # redirect_to signup_accounts_url and return
  end
  
  def login
    @customer = Customer.new
  end
  
  def authenticate
    if @customer = Customer.verify?(params[:customer][:email_username], params[:customer][:password])
      initialize_session(@customer)
      flash[:success] = 'Login success!'
      redirect_to redirect_to_url and return 
    else
      flash[:error] = "We're sorry but your login information is invalid"
      render 'login' and return
    end    
    # redirect_to login_accounts_url and return
  end
  
  def send_forgot
    CustomerMailer.forgot_password_request(params[:email]).deliver_now
    flash[:success] = 'Please check your email to reset your password'
    redirect_to order_services_url and return
  end
  
  def reset
    redirect_to order_services_url unless verify_url?(:email)
    @customer = Customer.find_by_email(params[:email])    
  end
  
  def reset_password
    @customer = Customer.find(customer_params[:id])
    @customer.reset_password = true
    if @customer.update_attributes(customer_params)
      flash[:success] = 'We have successfully reset your password'
      redirect_to order_services_url and return
    else
      flash[:error] = 'We are sorry, we cannot update your password at this time'
      @errors = @customer.errors
      render 'reset' and return
    end
  end
  
  protected
  
    def initialize_session(customer)
      session[:customer] = customer.sanitize!
    end
    
    def clear_session
      session[:customer] = nil
      session[:cart] = nil
    end
    
    def validate_logged_in
      return true if logged_in?
      # flash[:error] = 'You are already logged out'
      redirect_to order_services_url and return
    end

    def validate_logged_out
      return true unless logged_in?
      # flash[:error] = 'You are already logged in'
      redirect_to order_services_url and return false
    end    
    
end
