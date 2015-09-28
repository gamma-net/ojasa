class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_item
  
  delegate :product, :option, :sku, :final_price, :product_discount, :to => :product_item
  
  def discount
    original_price - sold_price
  end
end
