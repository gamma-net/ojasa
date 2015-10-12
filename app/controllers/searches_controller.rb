class SearchesController < ApplicationController
  layout 'admin'  
  
  before_filter :admin_authorize
  before_filter :validate_admin_permission

  def show
    category = params[:category] || 'all'
    
    @services = Service.where(category == 'all', "1=1", ["category_id = ?", category])
    
    render template: 'searches/results'
  end
  
end
