class Category < ActiveRecord::Base
  include Sort
  
  has_many :images
  
  belongs_to :parent_category, :class_name => 'Category'
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name

  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())") }

  before_create :initialize_sort!
  
  before_save :set_tag_name
  
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
  
  def pricings
    if tag_name.include?('cleaning')
      [{:value => '150000', :desc => '1 hour Rp 150.000,-'},
        {:value => '300000', :desc => '2 hours Rp 300.000,-'},
        {:value => '450000', :desc => '3 hours Rp 450.000,-'}]
    elsif tag_name.include?('massage')
      [{:value => '150000', :desc => '90 minutes Rp 150.000,-'},
        {:value => '175000', :desc => '120 minutes Rp 175.000,-'}]
    elsif tag_name.include?('car_salon')
      [{:value => '500000', :desc => 'Standard Rp 500.000,-'},
        {:value => '1000000', :desc => 'Full Rp 1.000.000,-'},
        {:value => '2500000', :desc => 'Coating Rp 2.500.000,-'}]
    elsif tag_name.include?('henna')
      [{:value => '200000', :desc => 'Foot to Ankle Rp 200.000,-'},
        {:value => '400000', :desc => 'Hands up to Wrist Rp 400.000,-'},
        {:value => '550000', :desc => 'Half Sleeves Rp 550.000,-'},
        {:value => '700000', :desc => 'Full Sleeves Rp 700.000,-'}]
    elsif tag_name.include?('hair_do')
      [{:value => '250000', :desc => ''}]
    elsif tag_name.include?('hijab_styling')
      [{:value => '250000', :desc => ''}]
    elsif tag_name.include?('ac_service')
      [{:value => '150000', :desc => '1 Unit Rp 150.000,-'},
        {:value => '300000', :desc => '2 Units Rp 300.000,-'},
        {:value => '450000', :desc => '3 Units Rp 450.000,-'}]
    else
      [{:value => '50000', :desc => '1 hour Rp 50.000,-'},
        {:value => '90000', :desc => '2 hours Rp 90.000,-'},
        {:value => '125000', :desc => '3 hours Rp 125.000,-'}]
    end
  end
  
  def parent_category_name
    parent_category.name if parent_category
  end 
  
  protected
    
    def set_tag_name
      self.tag_name = name.to_s.gsub(' ','_').downcase
    end
end
