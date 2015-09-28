class Product < ActiveRecord::Base
  include Sort
  
  has_many :images, as: :content, inverse_of: :content
  has_many :tag_relations, as: :content, inverse_of: :content  
  has_many :tags, through: :tag_relations
  
  has_and_belongs_to_many :collections

  has_many :product_items, -> { order :sort }
  alias :items :product_items
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name, :base_price, :base_sku
  validates_uniqueness_of :name, :scope => [:base_sku]
  
  before_create :initialize_sort!
  before_save :set_collections, :set_tags
  
  attr_accessor :collection_ids, :tag_ids
  
  def main_image
    image
  end
  
  def final_price
    sale_price || base_price
  end
  alias_method :product_final_price, :final_price
  
  protected
  
    def set_collections
      return if collection_ids.nil?
      self.collections.to_a.each {|c| collection_ids.include?(c.id.to_s) ? 
                                      collection_ids.delete(c.id.to_s) :
                                      self.collections.destroy(c)}

      collection_ids.each do |collection_id|
        next if collection_id.blank?
        self.collections << Collection.find(collection_id)
      end
    end

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
