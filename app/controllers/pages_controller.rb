class PagesController < ApplicationController
  
  before_filter :assign_instance_variables

  def show
    redirect_to order_services_url
  end
  
  protected
  
    def assign_instance_variables
      flash.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
end
