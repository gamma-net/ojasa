module ComicsHelper
  def comic_options
    Comic.all.order(:sort).collect {|c| [c.name, c.id]}
  end
end
