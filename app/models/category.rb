class Category < ActiveRecord::Base
  include Sort
  
  has_many :images
  
  belongs_to :events
  belongs_to :galleries
  belongs_to :news
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name

  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())") }

  before_create :initialize_sort!
  
  class << self
    def available(category_id)
      return Category.all.active unless category_id
      category = Category.find(category_id)
      Category.all - ([category] + category.child_categories)
    end
  end
  
  def child_categories
    categories = []
    Category.where(parent_category_id: id).active.each do |category|
      categories += [category]
      categories += category.child_categories
    end
    categories
  end 
end
