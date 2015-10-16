class TagRelation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :content, polymorphic: true
  
  belongs_to :service, -> { where("tag_relations.content_type = 'Service'") }, foreign_key: 'content_id'
end
