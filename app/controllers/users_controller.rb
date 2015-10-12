class UsersController < ApplicationController
  layout 'admin'
  
  before_filter :admin_authorize
  before_filter :validate_admin_permission
    
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User Create success!'
      redirect_to edit_admin_settings_user_url(id: @user.id) and return
    end
    @errors = @user.errors
    flash[:error] = "We're sorry, we cannot create the user at the moment"
    render template: 'users/new'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User Update success!'
      redirect_to edit_admin_settings_user_url and return
    end
    @errors = @user.errors
    flash[:error] = "We're sorry, we cannot update the user at the moment"
    render template: 'users/edit'
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_settings_users_url
  end
  
  # def sort
  #   User.sort!(params[:user][:sort])
  #   flash[:success] = 'User Sort success!'
  #   redirect_to admin_settings_users_url
  # end
  
end
