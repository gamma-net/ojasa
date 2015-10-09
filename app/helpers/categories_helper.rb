module CategoriesHelper
  def category_options
    [['-------------------', '']] + Category.all.order(:sort).collect {|c| [c.name, c.id]}
  end
  
  def parent_category_options(category_id)
    [['-------------------', '']] + Category.available(category_id).sort_by {|c| c.sort}.collect {|c| [c.name, c.id]}.compact
  end
end
