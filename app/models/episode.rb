class Episode < ActiveRecord::Base
  include Sort

  belongs_to :comic
  
  has_many :images, as: :content, inverse_of: :content, dependent: :destroy
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name
  
  before_create :initialize_sort!
  
  def sort_group_by; :comic_id; end
  
  def main_image
    image.exists? || (images.order(:sort).first && images.order(:sort).first.image)
  end
end
