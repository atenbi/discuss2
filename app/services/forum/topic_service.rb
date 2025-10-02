module Forum
  class TopicService
    def self.create_topic!(user_id:, category_id:, title:, content:, tag_ids: [])
      user = User.find(user_id)
      category = Category.find_by(id: category_id)
      topic = user.topics.build(category: category, title: title, content: content)

      return topic unless topic.valid?

      topic.save!
      assign_tags_to_topic(topic, tag_ids) if tag_ids.present?
      topic
    end

    def self.update_topic!(user_id:, category_id:, topic_id:, title:, content:, tag_ids: nil)
      topic = Topic.find(topic_id)
      category = Category.find_by(id: category_id)
      topic.assign_attributes(title: title, category: category, content: content)

      return topic unless topic.valid?

      topic.save!
      assign_tags_to_topic(topic, tag_ids) unless tag_ids.nil?
      topic
    end

    def self.delete_topic!(topic_id:)
      topic = Topic.find(topic_id)
      topic.destroy!
    end

    private

    def self.assign_tags_to_topic(topic, tag_ids)
      topic.taggables.destroy_all

      tag_ids = tag_ids.reject(&:blank?)
      tag_ids.each do |tag_id|
        topic.taggables.create!(tag_id: tag_id)
      end
    end
  end
end
