class EpisodesController < ApplicationController
  layout 'admin'

  def index
    @comic = Comic.find(params[:comic_id])
    @episodes = @comic.episodes.order(:sort)
  end
  
  def new
    @comic = Comic.find(params[:comic_id])
    @episode = Episode.new
  end
  
  def create
    @comic = Comic.find(params[:comic_id])
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:success] = 'Episode Create success!'
      redirect_to edit_admin_contents_comic_episode_url(id: @episode.id) and return
    end
    @errors = @episode.errors
    flash[:error] = "We're sorry, we cannot create the episode at the moment"
    render template: 'episodes/new'
  end
  
  def edit
    @comic = Comic.find(params[:comic_id])
    @episode = Episode.where(id: params[:id], comic_id: params[:comic_id]).first
  end
    
  def update
    @episode = Episode.find(params[:id])
    if @episode.update_attributes(episode_params)
      @comic = @episode.comic
      flash[:success] = 'Episode Update success!'
      redirect_to edit_admin_contents_comic_episode_url(comic_id: @episode.comic_id) and return
    end
    @comic = @episode.comic
    @errors = @episode.errors
    flash[:error] = "We're sorry, we cannot update the episode at the moment"
    render template: 'episodes/edit'
  end
  
  def destroy
    Episode.find(params[:id]).destroy
    redirect_to admin_contents_comic_episodes_url
  end
  
  def sort
    Episode.sort!(params[:episode][:sort])
    flash[:success] = 'Episode Sort success!'
    redirect_to admin_contents_comic_episodes_url
  end
  
  protected
    
    def episode_params
      params.require(:episode).permit!
    end

end
