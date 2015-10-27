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
      [{:value => '150000', :desc => 'Daily Cleaning - 90 minutes Rp 150.000,-'},
        {:value => '250000', :desc => 'Power Cleaning - 1 hour Rp 250.000,-'}]
    elsif tag_name.include?('massage')
      [{:value => '150000', :desc => 'Traditional Massage               - 90 minutes Rp 150.000,-'},
        {:value => '175000', :desc => 'Traditional Massage              - 120 minutes Rp 175.000,-'},
        {:value => '150000', :desc => 'Scrub Massage                    - 60 minutes Rp 150.000,-'},
        {:value => '175000', :desc => 'Sprains & Strains Massage        - 120 minutes Rp 175.000,-'},
        {:value => '100000', :desc => 'Baby & Child Massage             - 45 minutes Rp 100.000,-'},
        {:value => '150000', :desc => 'Head, Face & Ear Candle Massage  - 90 minutes Rp 150.000,-'},
        {:value => '125000', :desc => 'Reflexiology                     - 90 minutes Rp 125.000,-'},
        {:value => '200000', :desc => 'Tradisional Massage & Ear Candle - 120 minutes Rp 200.000,-'}]
    elsif tag_name.include?('car_salon')
      [{:value => '500000', :desc => 'Standard  - Rp 500.000,-'},
        {:value => '1000000', :desc => 'Full    - Rp 1.000.000,-'},
        {:value => '2500000', :desc => 'Coating - Rp 2.500.000,-'}]
    elsif tag_name.include?('henna')
      [{:value => '200000', :desc => 'Foot to Ankle       - Rp 200.000,-'},
        {:value => '400000', :desc => 'Hands up to Wrist  - Rp 400.000,-'},
        {:value => '550000', :desc => 'Half Sleeves       - Rp 550.000,-'},
        {:value => '700000', :desc => 'Full Sleeves       - Rp 700.000,-'}]
    elsif tag_name.include?('hair_do')
      [{:value => '250000', :desc => '1 Person - Rp 250.000'},
        {:value => '500000', :desc => '2 People - Rp 500.000'},
        {:value => '750000', :desc => '3 People - Rp 750.000'}]
    elsif tag_name.include?('hijab_styling')
      [{:value => '250000', :desc => '1 Person - Rp 250.000'},
        {:value => '500000', :desc => '2 People - Rp 500.000'},
        {:value => '750000', :desc => '3 People - Rp 750.000'}]
    elsif tag_name.include?('barber')
      [{:value => '100000', :desc => '1 Person - Rp 100.000'},
        {:value => '200000', :desc => '2 People - Rp 200.000'},
        {:value => '300000', :desc => '3 People - Rp 300.000'}]
    elsif tag_name.include?('ac_service')
      [{:value => '150000', :desc => '1 Unit    - Rp 150.000,-'},
        {:value => '300000', :desc => '2 Units  - Rp 300.000,-'},
        {:value => '450000', :desc => '3 Units  - Rp 450.000,-'}]
    elsif tag_name.include?('pest')
      [{:value => '450000', :desc => 'Rp 450.000,-'}]
    elsif tag_name.include?('garden')
      [{:value => '450000', :desc => 'Rp 450.000,-'}]
    elsif tag_name.include?('pool')
      [{:value => '150000', :desc => 'Rp 150.000,-'}]
    elsif tag_name.include?('groom')
      [{:value => '99000', :desc => 'Standard Bath - Rp 99.000'},
        {:value => '150000', :desc => 'Standard Bath + Mandi Jamur - Rp 150.000'},
        {:value => '150000', :desc => 'Standard + Flea Bath - Rp 150.000'},
        {:value => '150000', :desc => 'Standard Bath + Haircut - Rp 150.000'},
        {:value => '180000', :desc => 'Full Bath - Rp 180.000'}]
    elsif tag_name.include?('waxing')
      [{:value => '55000', :desc => 'Underarm (Sugar Wax)   - Rp 55.000,-'},
        {:value => '95000', :desc => 'Underarm (Hot Wax)    - Rp 95.000,-'},
        {:value => '70000', :desc => 'Halfarm (Sugar Wax)   - Rp 70.000,-'},
        {:value => '90000', :desc => 'Halfarm (Hot Wax)     - Rp 90.000,-'},
        {:value => '95000', :desc => 'Fullarm (Sugar Wax)   - Rp 95.000,-'},
        {:value => '150000', :desc => 'Fullarm (Hot Wax)     - Rp 150.000,-'},
        {:value => '80000', :desc => 'Chest (Sugar Wax)     - Rp 80.000,-'},
        {:value => '125000', :desc => 'Chest (Hot Wax)       - Rp 125.000,-'},
        {:value => '95000', :desc => 'Half Leg (Sugar Wax)  - Rp 95.000,-'},
        {:value => '135000', :desc => 'Half Leg (Hot Wax)    - Rp 135.000,-'},
        {:value => '145000', :desc => 'Full Leg (Sugar Wax)  - Rp 145.000,-'},
        {:value => '225000', :desc => 'Full Leg (Hot Wax)    - Rp 225.000,-'},
        {:value => '110000', :desc => 'Bikini (Sugar Wax)    - Rp 110.000,-'},
        {:value => '195000', :desc => 'Bikini (Hot Wax)      - Rp 195.000,-'},
        {:value => '155000', :desc => 'Brazilian (Sugar Wax) - Rp 155.000,-'},
        {:value => '285000', :desc => 'Brazilian (Hot Wax)   - Rp 285.000,-'},
        {:value => '40000', :desc => 'Eyebrow (Sugar Wax)   - Rp 40.000,-'},
        {:value => '60000', :desc => 'Eyebrow (Hot Wax)     - Rp 60.000,-'},
        {:value => '50000', :desc => 'Upperlip (Sugar Wax)  - Rp 50.000,-'},
        {:value => '70000', :desc => 'Upperlip (Hot Wax)    - Rp 70.000,-'}]
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
