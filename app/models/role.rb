class Role < ActiveRecord::Base
  include Sort
  
  belongs_to :users
  
  validates_presence_of :name
  
  before_create :initialize_sort!
end
