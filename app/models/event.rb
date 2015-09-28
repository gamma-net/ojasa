class Event < ActiveRecord::Base
  include Sort

  has_many :images, as: :content, inverse_of: :content, dependent: :destroy
  has_many :tag_relations, as: :content, inverse_of: :content  
  has_many :tags, through: :tag_relations
  
  validates_presence_of :title, :description, :venues
  
  before_create :initialize_sort!
  before_save :set_tags
  
  attr_accessor :tag_ids
  
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
