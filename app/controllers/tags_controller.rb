class TagsController < ApplicationController
  layout 'admin'

  def index
    @tags = Tag.all.order(:sort)
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag Create success!'
      redirect_to edit_admin_tag_url(id: @tag.id) and return
    end
    @errors = @tag.errors
    flash[:error] = "We're sorry, we cannot create the tag at the moment"
    render template: 'tags/new'
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tag_params)
      flash[:success] = 'Tag Update success!'
      redirect_to edit_admin_tag_url and return
    end
    @errors = @tag.errors
    flash[:error] = "We're sorry, we cannot update the tag at the moment"
    render template: 'tags/edit'
  end
  
  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_url
  end
  
  def sort
    Tag.sort!(params[:tag][:sort])
    flash[:success] = 'Tag Sort success!'
    redirect_to admin_tags_url
  end
  
  protected
    
    def tag_params
      params.require(:tag).permit!
    end
end
