class GalleriesController < ApplicationController
  layout 'admin'
  
  def index
    @galleries = Gallery.all.order(:sort)
  end

  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      flash[:success] = 'Gallery Create success!'
      redirect_to edit_admin_contents_gallery_url(id: @gallery.id) and return
    end
    @errors = @gallery.errors
    flash[:error] = "We're sorry, we cannot create the gallery at the moment"
    render template: 'galleries/new'
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end
  
  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(gallery_params)
      flash[:success] = 'Gallery Update success!'
      redirect_to edit_admin_contents_gallery_url and return
    end
    @errors = @gallery.errors
    flash[:error] = "We're sorry, we cannot update the gallery at the moment"
    render template: 'galleries/edit'
  end
  
  def destroy
    Gallery.find(params[:id]).destroy
    redirect_to admin_contents_galleries_url
  end
  
  def sort
    Gallery.sort!(params[:gallery][:sort])
    flash[:success] = 'Gallery Sort success!'
    redirect_to admin_contents_galleries_url
  end
  
  protected
    
    def gallery_params
      params.require(:gallery).permit!
    end
end
