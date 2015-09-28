class ApplicationController < ActionController::Base
  include Rack::Recaptcha::Helpers
  
  SITE_NAME = 'oJasa'.freeze
  SITE_ICON = ''.freeze
  SITE_LOGO = ''.freeze
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  # 
  # before_filter :validate_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]

  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  protected
    
    def user_params
      params.require(:user).permit!
    end
    
    def customer_params
      params.require(:customer).permit!
    end
     
    def admin_authorize
      if !admin_logged_in?
        redirect_to action_admin_url(action: 'login') and return
      end
    end
      
    def admin_logged_in?
      !session[:user].blank?
    end
    helper_method :admin_logged_in?
    
    def authorize
      if !logged_in?
        redirect_to '/' and return
      end
    end
      
    def logged_in?
      !session[:customer].blank?
    end
    helper_method :logged_in?
    
    def validate_admin_permission
      return false unless admin_logged_in?
      paths = request.path.split('/')[1..-1]
      
      if role = User.find(session[:user]['id']).role
        return true if role.permissions == 'all'
        while(true)
          break unless route_path = paths.delete_at(0)
          return true if role.permissions.split(',').detect {|perm| perm.strip == route_path}
        end unless role.permissions.blank?
      end
      
      redirect_to admin_dashboards_url and return false unless request.path == '/admin/dashboards'
    end
    # helper_method :validate_admin_permission
end
