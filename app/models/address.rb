class Address < ActiveRecord::Base
  has_one :customer
  has_one :shipping_order, class_name: 'Order', foreign_key: 'shipping_address_id'
  has_one :billing_order, class_name: 'Order', foreign_key: 'billing_address_id'
  
  def street
    "#{street1} #{street2}"
  end
  
  def full
    "#{street}, #{city}, #{region}, #{country}, #{postal_code}"
  end
end
