module Forum
  class TopicsController < ApplicationController
    include MarkdownSanitazable

    before_action :authenticate_user!, only: %i[new create edit update update_pinned destroy]
    before_action :set_topic, only: %i[edit update update_pinned show destroy]
    before_action :authorize_access!, only: %i[edit update update_pinned destroy]
    before_action :set_custom_select_items, only: %i[new edit create update]

    invisible_captcha only: [ :create ], on_spam: :redirect_spammer

    def index
      @category = Category.friendly.find_by(slug: params[:category])

      @q = Topic.ransack(ransack_params)

      @pagy, @topics = pagy_countless(
        TopicFinder.perform(ransack_params: ransack_params, params: params),
        params: { q: ransack_params, category: params[:category], tag: params[:tag] }
      )

      @selected_category_slug = @category&.slug

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def show
      @posts = @topic.posts.includes(:user).order(created_at: :asc)
      @topic_tags = @topic.tags
      @topic.increment!(:num_views)
      @post = Post.new

      meta_description = sanitize_markdown(@topic.content)

      set_meta_tags(
        title: @topic.title,
        description: meta_description,
        keywords: "#{@topic.category.name}, #{@topic_tags.pluck(:name).join(', ')}, discussion,  discuss²",
        type: "article",
        canonical: forum_topic_url(@topic)
      )
    end

    def new
      @topic = Topic.new
    end

    def edit
      @selected_category_id = @topic.category_id
    end

    def create
      @topic = TopicService.create_topic!(
        user_id: current_user.id,
        category_id: topic_params[:category_id],
        tag_ids: topic_params[:tag_ids],
        title: topic_params[:title],
        content: topic_params[:content]
      )

      if @topic.persisted?
        redirect_to forum_topic_path(@topic), notice: "Topic was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @topic = TopicService.update_topic!(
        user_id: current_user.id,
        category_id: topic_params[:category_id],
        tag_ids: topic_params[:tag_ids],
        topic_id: @topic.id,
        title: topic_params[:title],
        content: topic_params[:content]
      )

      if @topic.valid?
        redirect_to forum_topic_path(@topic), notice: "Topic was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update_pinned
      if params[:pin] == "true"
        @topic.pin!
        redirect_to forum_topic_path(@topic), notice: "Topic pinned successfully."
      else
        @topic.unpin!
        redirect_to forum_topic_path(@topic), notice: "Topic unpinned successfully."
      end
    end

    def destroy
      TopicService.delete_topic!(topic_id: @topic.id)

      respond_to do |format|
        format.html { redirect_to forum_topics_path, notice: "Topic was successfully deleted." }
        format.turbo_stream do
          flash[:notice] = "Topic was successfully deleted."
          render turbo_stream: turbo_stream.action(:redirect, forum_topics_path)
        end
      end
    end

    private

    def set_topic
      @topic = Topic.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to forum_topics_path, alert: "Topic not found."
    end

    def set_custom_select_items
      @select_default_item = Shared::CustomSelectComponent::Item.new("", "Please select")
      @select_items = [ @select_default_item ] + Category.all.map do |category|
        Shared::CustomSelectComponent::Item.new(category.id, category.name, category.bg_color)
      end
    end

    def topic_params
      params.require(:forum_topic).permit(:category_id, :title, :content, tag_ids: [])
    end

    def ransack_params
      @ransack_params ||=
        params.fetch(:q, {}).permit(:category_id_eq, :title_cont, :s).tap do |whitelisted|
          whitelisted[:category_id_eq] = @category.id if @category.present?
        end
    end

    def authorize_access!
      authorize @topic
    end
  end
end
