module ServicesHelper
  def fee_type_options
    Service::FEE_TYPES.collect {|k,v| [v, k]}
  end
  
  def service_options(category_id, location=nil)
    return [] unless category_id
    [['-------------------', '']] + Service.where(category_id: category_id).where(location ? "location LIKE '%#{location}%'" : "1=1").active.collect {|s| ["#{s.name} (#{s.contact_number})", s.id]}
  end
  
  def service_profile_image(order)
    return '' unless service = order.service
    
    image = image_tag(service.image_url, alt: service.name, class: "img-circle", style: "width: 220px;")
    raw(image)
  end
end
