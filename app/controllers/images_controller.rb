class ImagesController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  before_filter :validate_admin_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset, :signup]
  
  def create    
    @image = Image.new({image: params[:image], content_id: content_id, content_type: content_type})
    if @image.save
      render :json => { :files => [{
                                    "name" => @image.image_file_name,
                                    "size" => @image.image_file_size,
                                    "url" => @image.image.url,
                                    "thumbnail_url" => @image.image.url(:thumb),
                                    "delete_url" => delete_url,
                                    "delete_type" => @image.image_content_type
                                  }] }
    else
      render :json => [ {:error => "custom_failure"} ], :status => 404
    end
  end
  
  def destroy
    @image = Image.find(params[:id]).destroy
    redirect_to redirect_url
  end
  
  protected
    
    def parent_controller
      if params[:news_id]
        'news'
      elsif params[:event_id]
        'events'
      elsif params[:product_id]
        'products'
      elsif params[:episode_id]
        'episodes'
      elsif params[:gallery_id]
        'galleries'
      elsif params[:service_id]
        'services'
      end
    end
    
    def content_id
      case parent_controller
      when 'news';      params[:news_id]
      when 'events';    params[:event_id]
      when 'products';  params[:product_id]
      when 'episodes';  params[:episode_id]
      when 'galleries'; params[:gallery_id]
      when 'services';  params[:service_id]
      end      
    end
    
    def content_type
      case parent_controller
      when 'news';      'News'
      when 'events';    'Event'
      when 'products';  'Product'
      when 'episodes';  'Episode'
      when 'galleries'; 'Gallery'
      when 'services';  'Service'
      end
    end
        
    def delete_url
      case parent_controller
      when 'news';      admin_contents_news_image_url(id: @image.id)
      when 'events';    admin_contents_event_image_url(id: @image.id)
      when 'products';  admin_store_product_image_url(id: @image.id)
      when 'episodes';  admin_contents_comic_episode_image_url(id: @image.id)
      when 'galleries'; admin_contents_gallery_image_url(id: @image.id)
      when 'services';  admin_contents_service_image_url(id: @image.id)
      end
    end
    
    def redirect_url
      case parent_controller
      when 'news';      edit_admin_contents_news_url(id: content_id, anchor: 'images')
      when 'events';    edit_admin_contents_event_url(id: content_id, anchor: 'images')
      when 'products';  edit_admin_store_product_url(id: content_id, anchor: 'images')
      when 'episodes';  edit_admin_contents_comic_episode_url(id: content_id, anchor: 'images')
      when 'galleries'; edit_admin_contents_gallery_url(id: content_id, anchor: 'images')
      when 'services';  edit_admin_contents_service_url(id: content_id, anchor: 'images')
      end
    end
end
