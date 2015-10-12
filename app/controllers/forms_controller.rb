class FormsController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize
  before_filter :validate_admin_permission

end
