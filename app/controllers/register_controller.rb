class RegisterController < ApplicationController
  layout 'pages'

  before_filter :admin_authorize
  before_filter :validate_admin_permission

end
