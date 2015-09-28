module ServicesHelper
  def fee_type_options
    Service::FEE_TYPES.collect {|k,v| [v, k]}
  end
end
