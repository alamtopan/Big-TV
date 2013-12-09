module ApplicationHelper
  def colour_group(group)
    return "" unless group.colour
    "style='background-color:#{group.colour}; color:#fff'".html_safe
  end
end
