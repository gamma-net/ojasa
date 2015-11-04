module OrderServicesHelper
  def services_options_html
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
  
  def service_background_image
    if !params[:category_id].blank? && !params[:category_id].to_i.zero? && (category = Category.find(params[:category_id]))
      parent_category = category.parent_category
      parent_tag_name = (parent_category ? parent_category.tag_name : category.tag_name)
      image = if parent_tag_name.include?('cleaning'); 'bghome'
              elsif parent_tag_name.include?('beauty')
                if category.tag_name.include?('waxing'); 'bg-waxing'
                else; 'bg-beauty'
                end
              elsif parent_tag_name.include?('auto'); 'bg-car-wash'
              elsif parent_tag_name.include?('home')
                if category.tag_name.include?('ac_service'); 'bg-ac-service'
                else; 'bg-gardening'
                end
              elsif parent_tag_name.include?('massage'); 'bg-massage'
              end
    end
    
    images = ['bghome', 'bg-ac-service', 'bg-beauty', 'bg-car-wash', 'bg-gardening', 'bg-massage', 'bg-waxing']
    asset_path "images/#{image || images[rand(images.size)]}.jpg"
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
    8.upto(17) do |hour|
      hour_str = (hour < 10 ? '0' : '')
      hour_str << (hour.to_s + '.00')
      array << [hour_str, hour_str]
    end
  
    array
  end
  
  def service_requested_at_time
    raw('&nbsp;')
  end
  
  def randomize_background_image
    images = ['bghome', 'bg-ac-service', 'bg-beauty', 'bg-car-wash', 'bg-gardening', 'bg-massage', 'bg-waxing']
    image = images[rand(images.size)]
    asset_path "images/#{image}.jpg"
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
