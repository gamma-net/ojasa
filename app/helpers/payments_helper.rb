module PaymentsHelper
  def full_name
    "#{customer["first_name"]} #{customer["last_name"]}"
  end
  
  def email
    customer["email"]
  end
  
  def phone
    customer["phone"]
  end
  
  def full_address
    "#{customer["address"]} #{customer["addressdetail"]}"
  end    

  def address
    customer["address"]
  end

  def addressdetail
    customer["addressdetail"]
  end
  
  def category_name
    category = Category.find(cart["category_id"])
    category.name
  end
  
  def requested_date
    cart["requested_date"]
  end

  def requested_time
    cart["requested_time"]
  end
  
  def service_pricing_desc
    category = Category.find(cart["category_id"])
    pricing = category.pricings.detect {|pr| pr[:value] == cart["subtotal"]}
    pricing[:desc]
  end
  
  def region
    service_regions[cart["location"]]
  end

  def order_total
    order = Order.find(cart["order_id"])
    money_value(order.calculate_total)
  end
end
