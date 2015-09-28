class ComicsController < ApplicationController
  layout 'admin'
  
  def index
    @comics = Comic.all.order(:sort)
  end
  
  def new
    @comic = Comic.new
  end
  
  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      flash[:success] = 'Comic Create success!'
      redirect_to edit_admin_contents_comic_url(id: @comic.id) and return
    end
    @errors = @comic.errors
    flash[:error] = "We're sorry, we cannot create the comic at the moment"
    render template: 'comics/new'
  end

  def edit
    @comic = Comic.find(params[:id])
  end
  
  def update
    @comic = Comic.find(params[:id])
    if @comic.update_attributes(comic_params)
      flash[:success] = 'Comic Update success!'
      redirect_to edit_admin_contents_comic_url and return
    end
    @errors = @comic.errors
    flash[:error] = "We're sorry, we cannot update the comic at the moment"
    render template: 'comics/edit'
  end
  
  def destroy
    Comic.find(params[:id]).destroy
    redirect_to admin_contents_comics_url
  end
    
  def sort
    Comic.sort!(params[:comic][:sort])
    flash[:success] = 'Comic Sort success!'
    redirect_to admin_contents_comics_url
  end
  
  protected
    
    def comic_params
      params.require(:comic).permit!
    end

end
