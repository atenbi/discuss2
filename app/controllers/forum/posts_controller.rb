module Forum
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[edit update destroy]
    before_action :authorize_access!, only: %i[edit update destroy]

    invisible_captcha only: [ :create ], on_spam: :redirect_spammer

    def create
      Forum::PostService.create_post!(
        user_id: current_user.id,
        topic_id: post_params[:topic_id],
        content: post_params[:content]
      )

      redirect_to forum_topic_path(post_params[:topic_id])
    end

    def edit
      @topic = @post.topic
    end

    def update
      Forum::PostService.update_post!(
        post_id: @post.id,
        content: post_params[:content]
      )

      redirect_to forum_topic_path(@post.topic_id), notice: "Post updated successfully."
    end

    def destroy
      Forum::PostService.delete_post!(post_id: @post.id)

      redirect_to forum_topic_path(@post.topic_id), notice: "Post deleted successfully."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:forum_post).permit(:topic_id, :content)
    end

    def authorize_access!
      authorize @post
    end
  end
end
