class Feedback < ActiveRecord::Base
  belongs_to :order
  belongs_to :service
  
  validates_uniqueness_of :order_id, [:service_id]

  scope :current_service, ->(service_id) { where(service_id: service_id) }
end
