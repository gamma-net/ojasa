class Category < ActiveRecord::Base
  include Sort
  
  has_many :images
  has_many :orders
  
  belongs_to :parent_category, :class_name => 'Category'
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name

  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())").order(:sort) }

  before_create :initialize_sort!
  
  before_save :set_tag_name
  
  class << self
    def available(category_id)
      return Category.all.active unless category_id
      category = Category.find(category_id)
      Category.all - ([category] + category.child_categories)
    end
    
    def find_tag_name(string)
      where("tag_name LIKE '%#{string}%'").first
    end
  end
  
  def child_categories
    categories = []
    Category.where(parent_category_id: id).active.order(:sort).each do |category|
      categories += [category]
      categories += category.child_categories
    end
    categories
  end 
  
  def pricings
    if tag_name.include?('cleaning')
      [
        {:value => '150000', :desc => 'Daily Cleaning - 90 minutes Rp 150.000,-'},
        {:value => '250000', :desc => 'Power Cleaning - 1 hour Rp 250.000,-'}
      ]
    elsif tag_name.include?('massage')
      [
        {:value => '125000', :desc => 'Traditional Massage - 90 minutes Rp 125.000,-'},
        {:value => '150000', :desc => 'Traditional Massage - 120 minutes Rp 150.000,-'},
        {:value => '200000', :desc => 'Scrub Massage - 120 minutes Rp 200.000,-'},
        {:value => '150000', :desc => 'Sprains & Strains Massage - Max 60 minutes Rp 150.000,-'},
        {:value => '100000', :desc => 'Baby & Child Massage - Max 45 minutes Rp 100.000,-'},
        {:value => '150000', :desc => 'Head, Face & Ear Candle Massage - 90 minutes Rp 150.000,-'},
        {:value => '125000', :desc => 'Reflexiology - 90 minutes Rp 125.000,-'},
        {:value => '200000', :desc => 'Traditional Massage & Ear Candle - 120 minutes Rp 200.000,-'}
      ]
    elsif tag_name.include?('auto_polish')
      [
        {:value => '500000', :desc => 'Car Salon: Standard - Rp 500.000,-'}#,
        # {:value => '1000000', :desc => 'Car Salon: Full - Rp 1.000.000,-'},
        # {:value => '2500000', :desc => 'Car Salon: Coating - Rp 2.500.000,-'}
      ]
    elsif tag_name.include?('henna')
      [
        {:value => '200000', :desc => 'Foot to Ankle - Rp 200.000,-'},
        {:value => '400000', :desc => 'Hands up to Wrist - Rp 400.000,-'},
        {:value => '550000', :desc => 'Half Sleeves - Rp 550.000,-'},
        {:value => '700000', :desc => 'Full Sleeves - Rp 700.000,-'}
      ]
    elsif tag_name.include?('hair_do')
      [
        {:value => '250000', :desc => '1 Person - Rp 250.000'},
        {:value => '500000', :desc => '2 People - Rp 500.000'},
        {:value => '750000', :desc => '3 People - Rp 750.000'}
      ]
    elsif tag_name.include?('hijab_styling')
      [
        {:value => '250000', :desc => '1 Person - Rp 250.000'},
        {:value => '500000', :desc => '2 People - Rp 500.000'},
        {:value => '750000', :desc => '3 People - Rp 750.000'}
      ]
    elsif tag_name.include?('barber')
      [
        {:value => '100000', :desc => '1 Person - Rp 100.000'},
        {:value => '200000', :desc => '2 People - Rp 200.000'},
        {:value => '300000', :desc => '3 People - Rp 300.000'}
      ]
    elsif tag_name.include?('ac_service')
      [
        {:value => '150000', :desc => '1 Unit - Rp 150.000,-'},
        {:value => '300000', :desc => '2 Units - Rp 300.000,-'},
        {:value => '450000', :desc => '3 Units - Rp 450.000,-'}
      ]
    elsif tag_name.include?('pest')
      [
        {:value => '450000', :desc => 'Rp 450.000,-'}
      ]
    elsif tag_name.include?('garden')
      [
        {:value => '450000', :desc => 'Rp 450.000,-'}
      ]
    elsif tag_name.include?('pool')
      [
        {:value => '150000', :desc => 'Rp 150.000,-'}
      ]
    elsif tag_name.include?('groom')
      [
        {:value => '99000', :desc => 'Standard Bath - Rp 99.000'},
        {:value => '150000', :desc => 'Standard + Ringworm Bath - Rp 150.000'},
        {:value => '150000', :desc => 'Standard + Flea Bath - Rp 150.000'},
        {:value => '150000', :desc => 'Standard Bath + Haircut - Rp 150.000'},
        {:value => '180000', :desc => 'Full Bath - Rp 180.000'}
      ]
    elsif tag_name.include?('waxing')
      [
        {:value => '55000', :desc => 'Underarm (Sugar Wax) - Rp 55.000,-'},
        {:value => '95000', :desc => 'Underarm (Hot Wax) - Rp 95.000,-'},
        {:value => '70000', :desc => 'Halfarm (Sugar Wax) - Rp 70.000,-'},
        {:value => '90000', :desc => 'Halfarm (Hot Wax) - Rp 90.000,-'},
        {:value => '95000', :desc => 'Fullarm (Sugar Wax) - Rp 95.000,-'},
        {:value => '150000', :desc => 'Fullarm (Hot Wax) - Rp 150.000,-'},
        {:value => '80000', :desc => 'Chest (Sugar Wax) - Rp 80.000,-'},
        {:value => '125000', :desc => 'Chest (Hot Wax) - Rp 125.000,-'},
        {:value => '95000', :desc => 'Half Leg (Sugar Wax) - Rp 95.000,-'},
        {:value => '135000', :desc => 'Half Leg (Hot Wax) - Rp 135.000,-'},
        {:value => '140000', :desc => 'Full Leg (Sugar Wax) - Rp 140.000,-'},
        {:value => '225000', :desc => 'Full Leg (Hot Wax) - Rp 225.000,-'},
        {:value => '110000', :desc => 'Bikini (Sugar Wax) - Rp 110.000,-'},
        {:value => '195000', :desc => 'Bikini (Hot Wax) - Rp 195.000,-'},
        {:value => '155000', :desc => 'Brazilian (Sugar Wax) - Rp 155.000,-'},
        {:value => '285000', :desc => 'Brazilian (Hot Wax) - Rp 285.000,-'},
        {:value => '40000', :desc => 'Eyebrow (Sugar Wax) - Rp 40.000,-'},
        {:value => '60000', :desc => 'Eyebrow (Hot Wax) - Rp 60.000,-'},
        {:value => '50000', :desc => 'Upperlip (Sugar Wax) - Rp 50.000,-'},
        {:value => '70000', :desc => 'Upperlip (Hot Wax) - Rp 70.000,-'}
      ]
    elsif tag_name.include?('locksmith')
      [
        {:value => '200000', :desc => '1 Door - Rp 200.000,-'},
        {:value => '400000', :desc => '2 Doors - Rp 400.000,-'},
        {:value => '600000', :desc => '3 Doors - Rp 600.000,-'},
        {:value => '800000', :desc => '4 Doors - Rp 800.000,-'},
        {:value => '1000000', :desc => '5 Doors - Rp 1.000.000,-'}
      ]
    elsif tag_name.include?('yoga')
      [
        {:value => '500000', :desc => '1 Person / 60 minutes - Rp 500.000,-'},
        {:value => '700000', :desc => '2 People / 60 minutes - Rp 700.000,-'},
        {:value => '900000', :desc => '3 People / 60 minutes - Rp 900.000,-'}
      ]
    else
      []
    end
  end
  
  def pricing_desc(value)
    (pricing = pricings.detect {|pr| pr[:value] == value.to_s}) ? pricing[:desc] : ''
  end
  
  def working_hour
    if tag_name.include?('auto_polish'); [9, 17]
    elsif tag_name.include?('henna'); [4, 22]
    elsif tag_name.include?('make_up'); [1, 24]
    elsif tag_name.include?('waxing'); [9, 19]
    elsif tag_name.include?('yoga'); [17, 21]
    elsif tag_name.include?('pool'); [7, 17]
    elsif tag_name.include?('locksmith'); [8, 21]
    elsif tag_name.include?('massage'); [6, 24]      
    elsif tag_name.include?('groom'); [8, 15]      
    else; [8, 17]
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
