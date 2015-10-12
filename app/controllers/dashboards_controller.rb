class DashboardsController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize
  before_filter :validate_admin_permission

  def index
    redirect_to admin_contents_news_index_url
  end
end
