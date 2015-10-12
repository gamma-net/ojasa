class OrdersController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize
  before_filter :validate_admin_permission
    
  def index(status_id=Order.all_statuses)
    @orders = Order.where(status_id: status_id)
  end
  
  def show
    @order = Order.where(id: params[:id]).includes(:order_items).first
  end
  alias_method :edit, :show

  def update    
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params) && 
      @order.shipping_address.update_attributes(shipping_address_params) &&
      @order.billing_address.update_attributes(billing_address_params) &&
      @order.update_items(order_item_params)
      @order.calculate!
      flash[:success] = 'Order Update success!'
      redirect_to edit_admin_store_order_url and return
    end
    @errors = @order.errors
    flash[:error] = "We're sorry, we cannot update the order at the moment"
    render template: 'orders/edit'
  end
  
  def do_process
    Order.process!(params[:id])
    flash[:success] = 'Order has been processed successfully!'
    redirect_to admin_store_orders_url
  end
  
  def cancel
    Order.cancel!(params[:id])
    flash[:success] = 'Order has been cancelled successfully!'
    redirect_to admin_store_orders_url
  end

  def revert
    Order.open!(params[:id])
    flash[:success] = 'Order has been reverted to open successfully!'
    redirect_to admin_store_orders_url
  end
  
  def new
    render layout: "pages" #: false
  end
  
  
  def open
    index(Order.open)
    render 'index'
  end
  
  def pending_payment
    index(Order.pending_payment)
    render 'index'
  end

  def pending_work
    index(Order.pending_work)
    render 'index'
  end

  def processing
    index(Order.processing)
    render 'index'
  end

  def processed
    index(Order.processed)
    render 'index'
  end
  
  def cancelled
    index(Order.cancelled)
    render 'index'
  end
  
  
  protected
    
    def order_params
      params.require(:order).permit!
    end
    
    def shipping_address_params
      params.require(:shipping_address).permit!
    end
    
    def billing_address_params
      params.require(:billing_address).permit!
    end
    
    def order_item_params
      params.require(:order_item).permit!
    end
end
