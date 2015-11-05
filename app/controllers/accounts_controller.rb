class AccountsController < ApplicationController  
  layout 'order_services'
  
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
      redirect_to '/' and return
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
      redirect_to '/' and return 
    else
      flash[:error] = "We're sorry but your login information is invalid"
      render 'login' and return
    end    
    # redirect_to login_accounts_url and return
  end
  
  def reset
    redirect_to login_accounts_url and return
  end
  
  protected
  
    def initialize_session(customer)
      session[:customer] = customer.sanitize!
    end
    
    def clear_session
      session[:customer] = nil
      session[:cart] = nil
    end
end
