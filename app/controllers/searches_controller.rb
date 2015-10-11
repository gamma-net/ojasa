class SearchesController < ApplicationController
  layout 'admin'  
  
  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]

  def show
    category = params[:category] || 'all'
    
    @services = Service.where(category == 'all', "1=1", ["category_id = ?", category])
    
    render template: 'searches/results'
  end
  
end
