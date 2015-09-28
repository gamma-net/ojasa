module TagsHelper
  def status_options
    Tag::STATUSES.collect {|k,v| [v, k]}
  end
  
  def type_options
    [['All', '']] + Tag::TYPES.collect {|k,v| [v, k]}
  end
  
  def tagging_options
    Tag.all.collect {|t| [t.name, t.id]}
  end
end
