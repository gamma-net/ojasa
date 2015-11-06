class Service < ActiveRecord::Base
  include Sort

  has_many :images, as: :content, inverse_of: :content, dependent: :destroy
  has_many :tag_relations, as: :content, inverse_of: :content  
  has_many :tags, through: :tag_relations
  has_many :orders
  belongs_to :address, dependent: :destroy
  belongs_to :category
  
  validates_presence_of :name#, :description, :keyword
  
  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())") }
  
  before_create :initialize_sort!
  before_save :set_tags
  
  FEE_TYPES = {1 => 'Per Project',
                2 => 'Hourly',
                3 => 'Daily'}.freeze
            
  attr_accessor :tag_ids
  
  class << self
    def find_by_location_and_service(location, category_id)
      !Service.where(category_id: category_id).where("location LIKE '%#{location}%'").active.first.nil?
    end
  end
  
  def category_name
    category.name if category
  end
  
  def image_url
    'images/profile-picture.jpg'
  end

  protected

    def set_tags
      return if tag_ids.nil?
      self.tag_relations.to_a.each {|tr| tag_ids.include?(tr.tag_id.to_s) ? 
                                          tag_ids.delete(tr.tag_id.to_s) :
                                          tr.destroy}
      tag_ids.each do |tag_id|
        next if tag_id.blank?
        self.tags << Tag.find(tag_id)
      end
    end

end
