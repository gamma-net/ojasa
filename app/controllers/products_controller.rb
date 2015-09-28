class ProductsController < ApplicationController
  layout 'admin'
  
  def index
    @products = Product.all.order(:sort)
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Product Create success!'
      redirect_to edit_admin_store_product_url(id: @product.id) and return
    end
    @errors = @product.errors
    flash[:error] = "We're sorry, we cannot create the product at the moment"
    render template: 'products/new'
  end

  def edit
    @product = Product.where(id: params[:id]).includes(:product_items).first
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = 'Product Update success!'
      redirect_to edit_admin_store_product_url and return
    end
    @errors = @product.errors
    flash[:error] = "We're sorry, we cannot update the product at the moment"
    render template: 'products/edit'
  end
  
  def destroy
    Product.find(params[:id]).destroy
    redirect_to admin_store_products_url
  end
  
  def sort
    Product.sort!(params[:product][:sort])
    flash[:success] = 'Product Sort success!'
    redirect_to admin_store_products_url
  end
  
  protected
    
    def product_params
      params.require(:product).permit!
    end
end
