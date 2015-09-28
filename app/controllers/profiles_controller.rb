class ProfilesController < ApplicationController
  layout 'admin'

  def show
    @user = User.find(session[:user]['id'])
    render action: 'show'
  end
  alias_method :index, :show
  
  def update
    @user = User.find(user_params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile Update success!'
      redirect_to admin_settings_profiles_url and return
    end
    @errors = @user.errors
    flash[:error] = "We're sorry, we cannot update your profile at the moment"
    render template: 'profiles/show'
  end
end
