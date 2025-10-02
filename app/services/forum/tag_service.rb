module Forum
  class TagService
    def self.create_tag!(name:)
      Tag.create!(name: name)
    end

    def self.update_tag!(tag_id:, name:)
      tag = Tag.find(tag_id)
      tag.update!(name: name)
    end

    def self.delete_tag!(tag_id:)
      tag = Tag.find(tag_id)
      tag.destroy!
    end
  end
end
