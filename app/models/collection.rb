class Collection < ActiveRecord::Base
  include Sort
  
  has_many :images
  
  has_and_belongs_to_many :products
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name
  
  before_create :initialize_sort!
end
