class NewsController < ApplicationController
  layout 'admin'
  
  def index
    @news_items = News.all.order(:sort)
  end

  def new
    @news = News.new
  end
  
  def create
    @news = News.new(news_params)
    if @news.save
      flash[:success] = 'News Create success!'
      redirect_to edit_admin_contents_news_url(id: @news.id) and return
    end
    @errors = @news.errors
    flash[:error] = "We're sorry, we cannot create the news at the moment"
    render template: 'news/new'
  end

  def edit
    @news = News.find(params[:id])
  end
  
  def update
    @news = News.find(params[:id])
    if @news.update_attributes(news_params)
      flash[:success] = 'News Update success!'
      redirect_to edit_admin_contents_news_url and return
    end
    @errors = @news.errors
    flash[:error] = "We're sorry, we cannot update the news at the moment"
    render template: 'news/edit'
  end
  
  def destroy
    News.find(params[:id]).destroy
    redirect_to admin_contents_news_index_url
  end
    
  def sort
    News.sort!(params[:news][:sort])
    flash[:success] = 'News Sort success!'
    redirect_to admin_contents_news_index_url
  end
  
  protected
    
    def news_params
      params.require(:news).permit!
    end
end
