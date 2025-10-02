class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  layout :layout_by_resource
  helper_method :sidebar_categories, :sidebar_tags

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_meta_tags

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  if Rails.env.staging?
    http_basic_authenticate_with name: Rails.application.credentials.dig(:admin_staging, :username),
                                password: Rails.application.credentials.dig(:admin_staging, :password)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email password password_confirmation current_password])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || forum_topics_path)
  end

  def layout_by_resource
    if devise_controller?
      "auth"
    else
      "application"
    end
  end

  def sidebar_categories
    @sidebar_categories ||= Forum::Category.order(:name).first(5)
  end

  def sidebar_tags
    @sidebar_tags ||= Forum::Tag.joins(:taggables).group(:id).order("COUNT(forum_taggables.id) DESC").first(5)
  end

  def set_meta_tags(options = {})
    @meta_tags.merge!(options)
  end

  def initialize_meta_tags
    @meta_tags = {
      title: "Welcome to discuss² - a modern, open-source community platform.",
      description: "discuss² is lightweight, modern forum software for thoughtful online conversations-easy to set up, manage, and grow your community.",
      keywords: "forum, discussion, community,  discuss², open-source, lightweight, modern, easy-to-use, easy-to-set-up, easy-to-manage, easy-to-grow",
      canonical: request.original_url,
      image: helpers.image_url("discuss2-og-image.png"),
      "image:alt": "discuss² - a modern, open-source community platform."
    }
  end

  def redirect_spammer
    redirect_back(fallback_location: forum_topics_path, alert: "Sorry, spambots are not allowed!")
  end
end
