module RolesHelper
  def role_options
    [['No Role', nil]] + Role.all.order(:sort).collect {|r| [r.name, r.id]}
  end
end
