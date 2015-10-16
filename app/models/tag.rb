class Tag < ActiveRecord::Base
  include Sort

  has_many :tag_relations
  has_many :services, -> { where("tag_relations.content_type = 'Service'") }, through: :tag_relations
    
  STATUSES = {1 => 'Available',
              2 => 'Retracted',
              3 => 'Hidden'}.freeze
  
  TYPES = {'store'    => 'Store', 
            'content' => 'Content'}.freeze
  
  before_create :initialize_sort!
  
  def status_name
    STATUSES[status_id]
  end
end
