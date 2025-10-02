module UsersHelper
  def user_display_name(user)
    return "deleted_user" if user.deleted?
    user.username
  end

  def user_linkable?(user)
    user.present? && !user.deleted?
  end

  def user_avatar_color(user)
    return "#6b7280" if user.deleted?
    user.avatar_bg_color
  end

  def user_text_color_classes(user)
    return "text-[#6b7280]" if user.deleted?
    "text-sky-900 dark:text-sky-400"
  end

  def profile_topics_header(user)
    current_user == user ? "Your topics" : "#{user.username}'s topics"
  end

  def profile_posts_header(user)
    current_user == user ? "Your posts" : "#{user.username}'s posts"
  end
end
