class PagesController < ApplicationController
  
  before_filter :assign_instance_variables

  protected
  
    def assign_instance_variables
      flash.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
end
