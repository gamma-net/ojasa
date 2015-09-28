module OrdersHelper
  def order_status_options
    Order::STATUSES.collect {|k,v| [v, k]}
  end
  
  def status_name(status)
    status = "<b>#{status}</b>" if status == 'Pending Work'
    raw(status)
  end
end
