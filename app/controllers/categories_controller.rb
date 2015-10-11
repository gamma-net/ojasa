class CategoriesController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  def index
    @categories = Category.all.order(:sort)
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category Create success!'
      redirect_to edit_admin_contents_category_url(id: @category.id) and return
    end
    @errors = @category.errors
    flash[:error] = "We're sorry, we cannot create the category at the moment"
    render template: 'categories/new'
  end
    
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = 'Category Update success!'
      redirect_to edit_admin_contents_category_url and return
    end
    @errors = @category.errors
    flash[:error] = "We're sorry, we cannot update the category at the moment"
    render template: 'categories/edit'
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_contents_categories_url
  end
  
  def sort
    Category.sort!(params[:category][:sort]) if params[:category]
    flash[:success] = 'Category Sort success!'
    redirect_to admin_contents_categories_url
  end
  
  protected
    
    def category_params
      params.require(:category).permit!
    end
end
