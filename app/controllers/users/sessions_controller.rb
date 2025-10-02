class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    forum_topics_path
  end

  def after_sign_out_path_for(resource_or_scope)
    forum_topics_path
  end
end
