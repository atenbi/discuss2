module SidebarHelper
  def active_item_class(item, current_item)
    return active_link_styles if item.to_s == current_item.to_s

    inactive_link_styles
  end

  def active_link_class(path)
    return inactive_link_styles unless current_page?(path)
    return inactive_link_styles if topics_path_with_filters?(path)

    active_link_styles
  end

  private

  def topics_path_with_filters?(path)
    path == forum_topics_path && (params[:category].present? || params[:tag].present?)
  end

  def active_link_styles
    "bg-neutral-200 dark:bg-gray-700 text-gray-900 dark:text-white font-semibold"
  end

  def inactive_link_styles
    "text-gray-700 dark:text-gray-300 hover:bg-neutral-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white"
  end
end
