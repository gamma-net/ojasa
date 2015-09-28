module CategoriesHelper
  def category_options
    [['Uncatagorized', '']] + Category.all.order(:sort).collect {|c| [c.name, c.id]}
  end
end
