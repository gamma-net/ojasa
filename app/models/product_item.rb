class ProductItem < ActiveRecord::Base
  include Sort
  
  belongs_to :product
  
  validates_presence_of :sku
  
  before_create :initialize_sort!
  
  delegate :name, :base_price, :product_final_price, :to => :product
  
  def name_option
    str = name
    str << " (#{option})" unless option.blank?
    str << " [#{sku}]"
  end
  
  def final_price
    sale_price || price || product_final_price
  end
  
  def original_price
    price || base_price
  end
  
  def product_discount
    original_price - final_price
  end
end
