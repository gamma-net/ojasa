module AdminHelper
  def span_selected(string)
	  raw('<span class="selected"></span>') if request.path.include?(string)
  end
  
  def is_open?(string)
    ' open' if is_active?(string)
  end
  
  def li_active_open?(string)
    li_active?(string, true)
	end
	
	def is_active?(string)
    request.path.include?(string)
  end
  
  def li_active?(string, open=false)
    str = '<li'
    if is_active?(string)
      str << ' class="active'
      str << ' open' if open
      str << '"'
    end
    str << '>'
    raw(str)
  end
  
  def datetime_value(t)
    t.strftime("%d %B %Y - %H:%M") if t
  end
  
  def date_value(t)
    t.strftime("%Y-%m-%d") if t
  end

  def time_value(t)
    t.strftime("%H:%M") if t
  end
  
  def number_format(number, format=:plain)
    default_options = { 
                        precision: 2, 
                        strip_insignificant_zeros: true
                      }
              
    case format
    when :plain
      number_with_precision(number, default_options)
    end
  end
  
  def money_value(number, custom_options={})
    default_options = { 
                        unit: "IDR ", 
                        precision: 2, 
                        delimiter: '.', 
                        strip_insignificant_zeros: true
                      }
    number_to_currency(number, default_options.merge(custom_options))
  end
end
