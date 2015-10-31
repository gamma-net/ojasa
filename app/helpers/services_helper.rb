module ServicesHelper
  def fee_type_options
    Service::FEE_TYPES.collect {|k,v| [v, k]}
  end
  
  def service_options(category_id)
    return [] unless category_id
    [['-------------------', '']] + Service.where(category_id: category_id).active.collect {|s| [s.name, s.id]}
  end
end
