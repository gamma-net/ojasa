class RolesController < ApplicationController
  layout 'admin'
  
  def index
    @roles = Role.all.order(:sort)
  end
  
  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:success] = 'Role Create success!'
      redirect_to edit_admin_settings_role_url(id: @role.id) and return
    end
    @errors = @role.errors
    flash[:error] = "We're sorry, we cannot create the role at the moment"
    render template: 'roles/new'
  end

  def edit
    @role = Role.find(params[:id])
  end
  
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      flash[:success] = 'Role Update success!'
      redirect_to edit_admin_settings_role_url and return
    end
    @errors = @role.errors
    flash[:error] = "We're sorry, we cannot update the role at the moment"
    render template: 'roles/edit'
  end
  
  def destroy
    Role.find(params[:id]).destroy
    redirect_to admin_settings_roles_url
  end
  
  def sort
    Role.sort!(params[:role][:sort])
    flash[:success] = 'Role Sort success!'
    redirect_to admin_settings_roles_url
  end
  
  protected
    
    def role_params
      params.require(:role).permit!
    end
  
end
