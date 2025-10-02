class Users::RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: [ :create ], on_spam: :redirect_spammer

  protected

  def after_sign_up_path_for(resource)
    forum_topics_path
  end

  private

  def redirect_spammer
    redirect_back(fallback_location: forum_topics_path, alert: "Sorry, spambots are not allowed!")
  end
end
