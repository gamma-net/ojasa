class SearchesController < ApplicationController
  layout 'admin'
  
  def show
    category = params[:category] || 'all'
    
    @services = Service.where(category == 'all', "1=1", ["category_id = ?", category])
    
    render template: 'searches/results'
  end
  
end
