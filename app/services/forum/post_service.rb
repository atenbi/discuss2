module Forum
  class PostService
    def self.create_post!(user_id:, topic_id:, content:)
      user = User.find(user_id)
      topic = Topic.find(topic_id)
      topic.posts.create!(user: user, content: content)
    end

    def self.update_post!(post_id:, content:)
      post = Post.find(post_id)
      post.update!(content: content)
    end

    def self.delete_post!(post_id:)
      post = Post.find(post_id)
      post.destroy!
    end
  end
end
