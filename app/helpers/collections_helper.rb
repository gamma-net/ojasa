module CollectionsHelper
  def collection_options
    Collection.all.order(:sort).collect {|c| [c.name, c.id]}
  end
end
