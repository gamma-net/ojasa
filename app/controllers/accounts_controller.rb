class AccountsController < ApplicationController
  layout 'pages'
  
  def logout
    clear_session
    redirect_to '/'
  end
  
  def register
    customer = Customer.new(customer_params)
    if customer.save
      initialize_session(customer)
      flash[:success] = 'Login success!'
      redirect_to '/' and return
    end
    flash[:error] = "We're sorry but we cannot sign you up at the moment"
    redirect_to action_accounts_url(action: 'signup') and return
  end
  
  def authenticate
    if customer = Customer.verify?(params[:customer][:email_username], params[:customer][:password])
      initialize_session(customer)
      flash[:success] = 'Login success!'
      redirect_to '/' and return 
    end
    
    flash[:error] = "We're sorry but your login information is invalid"
    redirect_to action_accounts_url(action: 'login') and return
  end
  
  def reset
    redirect_to action_accounts_url(action: 'login') and return
  end
  
  protected
  
    def initialize_session(customer)
      session[:customer] = customer.sanitize!
    end
    
    def clear_session
      session[:customer] = nil
    end
end
