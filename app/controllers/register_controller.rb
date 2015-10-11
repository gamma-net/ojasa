class RegisterController < ApplicationController
  layout 'pages'

  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]

end
