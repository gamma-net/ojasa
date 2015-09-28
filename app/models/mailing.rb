class Mailing < ActiveRecord::Base
  TYPES = {1 => 'Blast',
            2 => 'Notification',
            3 => 'Private'}.freeze
            
  validates_presence_of :subject
  
end
