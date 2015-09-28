class CustomersController < ApplicationController
  layout 'admin'

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = 'Customer Create success!'
      redirect_to edit_admin_store_customer_url(id: @customer.id) and return
    end
    @errors = @customer.errors
    flash[:error] = "We're sorry, we cannot create the customer at the moment"
    render template: 'customers/new'
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = 'Customer Update success!'
      redirect_to edit_admin_store_customer_url and return
    end
    @errors = @customer.errors
    flash[:error] = "We're sorry, we cannot update the customer at the moment"
    render template: 'customers/edit'
  end

  def destroy
    Customer.find(params[:id]).destroy
    redirect_to admin_store_customers_url
  end
  
  # def sort
  #   Customer.sort!(params[:customer][:sort])
  #   flash[:success] = 'Customer Sort success!'
  #   redirect_to admin_store_customers_url
  # end
  
  protected
    
    def customer_params
      params.require(:customer).permit!
    end
end
