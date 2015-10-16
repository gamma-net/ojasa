class Image < ActiveRecord::Base
  include Sort
  
  belongs_to :content, :polymorphic => true
  belongs_to :banner, -> { where("images.content_type = 'Banner'") }, foreign_key: 'content_id'
  belongs_to :category, -> { where("images.content_type = 'Category'") }, foreign_key: 'content_id'
  belongs_to :gallery, -> { where("images.content_type = 'Gallery'") }, foreign_key: 'content_id'
  belongs_to :news, -> { where("images.content_type = 'News'") }, foreign_key: 'content_id'
  belongs_to :service, -> { where("images.content_type = 'Service'") }, foreign_key: 'content_id'
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  before_create :initialize_sort!
  
end
