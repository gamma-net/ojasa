class ProductItemsController < ApplicationController
  layout 'admin'
  
  def index
    @product_items = ProductItem.where(product_id: params[:product_id]).order(:sort)
  end

  def new
    @product_item = ProductItem.new
  end
  
  def create
    @product_item = ProductItem.new(product_item_params)
    if @product_item.save
      flash[:success] = 'Product Item Create success!'
      redirect_to edit_admin_store_product_item_url(id: @product_item.id) and return
    end
    @errors = @product_item.errors
    flash[:error] = "We're sorry, we cannot create the product item at the moment"
    render template: 'product_items/new'
  end

  def edit
    @product_item = ProductItem.where(id: params[:id], product_id: params[:product_id]).first
  end
  
  def update
    @product_item = ProductItem.where(id: params[:id], product_id: params[:product_id]).first
    if @product_item.update_attributes(product_item_params)
      flash[:success] = 'Product Item Update success!'
      redirect_to edit_admin_store_product_item_url and return
    end
    @errors = @product_item.errors
    flash[:error] = "We're sorry, we cannot update the product item at the moment"
    render template: 'product_items/edit'
  end
  
  def destroy
    ProductItem.where(id: params[:id], product_id: params[:product_id]).first.destroy
    redirect_to edit_admin_store_product_url(id: params[:product_id])
  end
  
  def sort
    ProductItem.sort!(params[:product_item][:sort]) unless params[:product_item].blank? || params[:product_item][:sort].blank?
    flash[:success] = 'Product Item Sort success!'
    redirect_to edit_admin_store_product_url(id: params[:product_id], anchor: "items")
  end
  
  protected
    
    def product_item_params
      params.require(:product_item).permit!
    end
end
