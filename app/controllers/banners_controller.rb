class BannersController < ApplicationController
  layout 'admin'

  def index
    @banners = Banner.all.order(:sort)
  end
  
  def new
    @banner = Banner.new
  end
  
  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      flash[:success] = 'Banner Create success!'
      redirect_to edit_admin_contents_banner_url(id: @banner.id) and return
    end
    @errors = @banner.errors
    flash[:error] = "We're sorry, we cannot create the banner at the moment"
    render template: 'banners/new'
  end
  
  def edit
    @banner = Banner.find(params[:id])
  end

  def update
    @banner = Banner.find(params[:id])
    if @banner.update_attributes(banner_params)
      flash[:success] = 'Banner Update success!'
      redirect_to edit_admin_contents_banner_url and return
    end
    @errors = @banner.errors
    flash[:error] = "We're sorry, we cannot update the banner at the moment"
    render template: 'banners/edit'
  end
  
  def destroy
    Banner.find(params[:id]).destroy
    redirect_to admin_contents_banners_url
  end
  
  def sort
    Banner.sort!(params[:banner][:sort])
    flash[:success] = 'Banner Sort success!'
    redirect_to admin_contents_banners_url
  end
  
  protected
    
    def banner_params
      params.require(:banner).permit!
    end
end
