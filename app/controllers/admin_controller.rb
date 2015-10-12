class AdminController < ApplicationController
  layout 'login'
  
  def show
    if admin_logged_in?
      redirect_to admin_dashboards_url
    else
      redirect_to action_admin_url(action: 'login')
    end
  end

  def logout
    clear_session
    redirect_to admin_url
  end
  
  def register
    user = User.new(user_params)
    if user.save
      initialize_session(user)
      flash[:success] = 'Login success!'
      redirect_to admin_url and return
    end
    flash[:error] = "We're sorry but we cannot sign you up at the moment"
    redirect_to action_admin_url(action: 'registration') and return
  end
  
  def authenticate
    if user = User.verify?(params[:user][:email_username], params[:user][:password])
      initialize_session(user)
      flash[:success] = 'Login success!'
      redirect_to admin_url and return 
    end
    
    flash[:error] = "We're sorry but your login information is invalid"
    redirect_to action_admin_url(action: 'login') and return
  end
  
  def reset
    redirect_to action_admin_url(action: 'login') and return
  end
  

  protected
  
    def initialize_session(user)
      session[:user] = user.sanitize!
    end
    
    def clear_session
      session[:user] = nil
    end
end
