class Banner < ActiveRecord::Base
  include Sort
  
  has_many :images
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name, :link_url, :publish_at, :retract_at

  before_create :initialize_sort!

end
