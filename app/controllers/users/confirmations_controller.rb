# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      resource.update(state: :activated) if resource.confirmed?

      flash[:notice] = t "devise.confirmations.confirmed"

      redirect_to after_confirmation_path_for(resource_name, resource)
    else
      flash[:alert] = "Something went wrong. Try to resend confirmation email."
      redirect_to new_user_confirmation_path(resource_name)
    end
  end

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    forum_topics_path
  end
end
