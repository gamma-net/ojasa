module OrderServicesHelper
  def services_options_html
    #     str = <<-EOF
    #     <option value="" selected>Services</option>
    # <optgroup label="Picnic">
    # <option>Mustard</option>
    # <option>Ketchup</option>
    # <option>Relish</option>
    # <optgroup label="Picnic" class="sub-menu">
    # <option style="margin-left:23px;">Mustard</option>
    # <option style="margin-left:23px;">Ketchup</option>
    # <option style="margin-left:23px;">Relish</option>
    # </optgroup>
    # </optgroup>
    # <optgroup label="Camping">
    # <option>Tent</option>
    # <option>Flashlight</option>
    # <option>Toilet Paper</option>
    # </optgroup>
    #     EOF
	  
	  str = '<option value="" selected>Services</option>'
	  Category.where("parent_category_id IS NULL").active.each do |p_category|
	    str << child_services_options(p_category)
	  end
	  str << '</option>'
	  
	  raw(str)
  end
  
  def service_regions
    {'jaksel' => 'Jakarta Selatan', 
      'jaktim' => 'Jakarta Timur',
      'jakpus' => 'Jakarta Pusat',
      'jakut' => 'Jakarta Utara',
      'jakbar' => 'Jakarta Barat',
      'bintaro' => 'Bintaro',
      'depok' => 'Depok',
      'bekasi' => 'Bekasi',
      'bogor' => 'Bogor',
      'Tangerang' => 'Tangerang'}
  end
    
  def services_location_options
    array = []
    service_regions.each {|key, value| array << [value, key]}
    array
  end
  
  def services_location_options_html
    options_for_select([['Location', '']] + services_location_options, cart["location"])
  end
  
  def services_days_options
    days = {'senin' => 'Senin', 
            'selasa' => 'Selasa',
            'rabu' => 'Rabu',
            'kamis' => 'Kamis',
            'jumat' => "Jum'at",
            'sabtu' => 'Sabtu',
            'minggu' => 'Minggu'}

    # str = ''
    # days.each do |key, value|
    #   str << '<option value="'
    #   str << key
    #   str << '">'
    #   str << value
    #   str << '</option>'
    # end
    # 
    # raw(str)
    array = []
    days.each {|key, value| array << [value, key]}
    array
  end
  
  def service_name
    if !params[:category_id].blank? && !params[:category_id].to_i.zero? && (category = Category.find(params[:category_id]))
      return category.name
    end

    if !params[:service_type].blank? && (category = Category.find_tag_name(params[:service_type]))
      return category.name
    end
    
    return params[:service_type].capitalize
  end
  
  def service_description
    str = "" #dusting . sweep . vacum and mop<br>room tidying . dish washing . toilet sanitizing"
    
    raw(str)
  end
  
  def service_category_id
    return params[:category_id] unless params[:category_id].blank?
    if !params[:service_type].blank? && !params[:service_type].to_i.zero? && (category = Category.find_tag_name(params[:service_type]))
      return category.id
    end
  end
  
  def service_location
    session[:cart]["location"]
  end

  def service_pricing
    category = Category.find(service_category_id)
    if false && (category.pricings.size == 1)
      
    else
      str = '<select id="cleaning-form-price" name="order[subtotal]" class="input-lg sm-form-control">' # multiple=true
      category.pricings.each do |pricing|
        str << '<option value="'
        str << pricing[:value]
        str << '"'
        str << ' selected' if cart["subtotal"].to_s == pricing[:value]
        str << '>'
        str << pricing[:desc]
        str << '</option>'
      end
      str << '</select>'
    end
    
    raw(str)
  end
  
  def service_requested_time_options
    array = [['Choose Time','']]
    0.upto(23) do |hour|
      hour_str = (hour < 10 ? '0' : '')
      hour_str << (hour.to_s + '.00')
      array << [hour_str, hour_str]
    end
  
    array
  end
  
  def service_requested_at_time
    raw('&nbsp;')
  end
  
  protected
  
    def child_services_options(category)
      str = ''
      if (categories = category.child_categories).empty?
        str << '<option value="'
        str << category.id.to_s
        str << '"'
        str << " selected" if cart["category_id"].to_s == category.id.to_s
        str << '>'
        str << category.name
        str << '</option>'
      else
        str << '<optgroup label="'
  	    str << category.name
  	    str << '">'
	      categories.each do |c_category|
	        str << child_services_options(c_category)
        end
  	    str << '</optgroup>'
	    end
	    str
    end
  
end
