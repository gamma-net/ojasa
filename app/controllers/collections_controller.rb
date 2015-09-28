class CollectionsController < ApplicationController
  layout 'admin'

  def index
    @collections = Collection.all.order(:sort)
  end
  
  def new
    @collection = Collection.new
  end
  
  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      flash[:success] = 'Collection Create success!'
      redirect_to edit_admin_store_collection_url(id: @collection.id) and return
    end
    @errors = @collection.errors
    flash[:error] = "We're sorry, we cannot create the collection at the moment"
    render template: 'collections/new'
  end
    
  def edit
    @collection = Collection.find(params[:id])
  end
  
  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(collection_params)
      flash[:success] = 'Collection Update success!'
      redirect_to edit_admin_store_collection_url and return
    end
    @errors = @collection.errors
    flash[:error] = "We're sorry, we cannot update the collection at the moment"
    render template: 'collections/edit'
  end
  
  def destroy
    Collection.find(params[:id]).destroy
    redirect_to admin_store_collections_url
  end
  
  def sort
    Collection.sort!(params[:collection][:sort])
    flash[:success] = 'Collection Sort success!'
    redirect_to admin_store_collections_url
  end
  
  protected
    
    def collection_params
      params.require(:collection).permit!
    end
end
