class ServicesController < ApplicationController
  layout 'admin'
  
  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]

  def index
    @services = Service.all.order(:sort)
  end

  def new
    @service = Service.new
    @service.address = Address.new
  end
  
  def create
    @service = Service.new(service_params)
    # @service.address = Address.new(service_address_params)
    if @service.save
      flash[:success] = 'Service Create success!'
      redirect_to edit_admin_contents_service_url(id: @service.id) and return
    end
    @errors = @service.errors
    flash[:error] = "We're sorry, we cannot create the service at the moment"
    render template: 'services/new'
  end

  def edit
    @service = Service.find(params[:id])#.includes(:address).first
    @service.address ||= Address.new
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(service_params) #&& @service.address.update_attributes(service_address_params)
      flash[:success] = 'Service Update success!'
      redirect_to edit_admin_contents_service_url and return
    end
    @errors = @service.errors
    flash[:error] = "We're sorry, we cannot update the service at the moment"
    render template: 'services/edit'
  end
  
  def destroy
    Service.find(params[:id]).destroy
    redirect_to admin_contents_services_url
  end
  
  def sort
    Service.sort!(params[:service][:sort]) if params[:service]
    flash[:success] = 'Service Sort success!'
    redirect_to admin_contents_services_url
  end
  
  protected
    
    def service_params
      params[:service][:location] = params[:service][:location].join(',') if params[:service][:location]
      params[:service][:days] = params[:service][:days].join(',') if params[:service][:days]
      params.require(:service).permit!
    end
    
    def service_address_params
      params.require(:service_address).permit!
    end
end
