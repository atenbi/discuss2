module CustomSelectComponentHelper
  def render_custom_select_item(item)
    content_tag(:div, class: "flex items-center space-x-2") do
      if item.color.present?
        concat(content_tag(:div, "", style: "width: 12px; height: 12px; background-color: #{item.color};"))
      end
      concat(content_tag(:div, item.label))
    end
  end
end
