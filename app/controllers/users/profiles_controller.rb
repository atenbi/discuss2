class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update edit_password update_password soft_delete]

  def show
    @pagy_topics, @topics = pagy(@user.topics.order(active_at: :desc), limit: 2, page_param: :topics_page)
    @pagy_posts, @posts = pagy(@user.posts.includes(:topic).order(created_at: :desc), limit: 2, page_param: :posts_page)

    @topics_count = @user.topics_count
    @posts_count = @user.posts_count

    @meta_tags = {
      title: "#{@user.username}'s Profile",
      description: "View #{@user.username}'s profile with #{@topics_count} topics and #{@posts_count} posts",
      keywords: "#{@user.username}, profile, forum, discussion,  discuss²",
      canonical: profile_url(@user)
    }
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password; end

  def update_password
    if @user.update_with_password(password_params)
      bypass_sign_in(@user)
      redirect_to profile_path, notice: "Password updated successfully."
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  def soft_delete
    if UserSoftDeletionService.call(user_id: current_user.id)
      sign_out(current_user)

      respond_to do |format|
        format.html { redirect_to forum_topics_path, notice: "Your account has been successfully deleted." }
        format.turbo_stream do
          flash[:notice] = "Your account has been successfully deleted."
          render turbo_stream: turbo_stream.action(:redirect, forum_topics_path)
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_profile_path, alert: "Failed to delete account. Please try again." }
        format.turbo_stream do
          flash[:alert] = "Failed to delete account. Please try again."
          render turbo_stream: turbo_stream.action(:redirect, edit_profile_path)
        end
      end
    end
  end

  private

  def set_user
    @user = params[:id] ? User.friendly.find(params[:id]) : current_user

    redirect_to forum_topics_path, alert: "User not found." if @user&.deleted?

  rescue ActiveRecord::RecordNotFound
    redirect_to forum_topics_path, alert: "User not found."
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
