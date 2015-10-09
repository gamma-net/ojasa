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
  
  def services_location_options
    regions = {'jaksel' => 'Jakarta Selatan', 
                'jaktim' => 'Jakarta Timur',
                'jakpus' => 'Jakarta Pusat',
                'jakut' => 'Jakarta Utara',
                'jakbar' => 'Jakarta Barat',
                'bintaro' => 'Bintaro',
                'depok' => 'Depok',
                'bekasi' => 'Bekasi'}

    # str = ''
    # regions.each do |key, value|
    #   str << '<option value="'
    #   str << key
    #   str << '">'
    #   str << value
    #   str << '</option>'
    # end
    # 
    # raw(str)
    array = []
    regions.each {|key, value| array << [value, key]}
    array
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
    if !params[:service_type].blank? && !params[:service_type].to_i.zero? && (category = Category.find(params[:service_type]))
      return category.name
    end
    
    case params[:service_type]
    when 'cleaning';  'Cleaning Services'
    when 'salon';     'Hair Salon'
    when 'carwash';   'Car Wash'
    when 'autocare';  'Auto Care'
    when 'gardener';  'Gardener'
    when 'massage';   'Massage'
    when 'ac';        'AC Services'
    else; params[:action].capitalize
    end
  end
  
  def service_description
    str = "dusting . sweep . vacum and mop<br>room tidying . dish washing . toilet sanitizing"
    
    raw(str)
  end
  
  def service_pricing
    str = <<-EOF
      <!--select id="cleaning-form-price" name="order[subtotal]" class="input-lg input-xlarge select2me bs-select form-control not-dark"-->
      <select id="cleaning-form-price" name="order[subtotal]" class="controls form-control placeholder-no-fix required input-lg not-dark">
          <option value="">how many hour</option>
          <option value="50000">1 hour Rp.50.000,-</option>
          <option value="90000">2 hours Rp.90.000</option>
          <option value="125000">3 hours Rp.125.000</option>
      </select>
    EOF

    raw(str)
  end
  
  protected
  
    def child_services_options(category)
      str = ''
      if (categories = category.child_categories).empty?
        str << '<option value="'
        str << category.id.to_s
        str << '">'
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
