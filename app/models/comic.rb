class Comic < ActiveRecord::Base
  include Sort
  
  has_many :images
  has_many :episodes
  belongs_to :category
  
  has_many :tag_relations, as: :content, inverse_of: :content
  has_many :tags, through: :tag_relations
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name
  
  before_create :initialize_sort!
  before_save :set_tags
  
  attr_accessor :tag_ids

  def main_image
    image.exists? || (episodes.order(:sort).first && episodes.order(:sort).first.main_image)
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
