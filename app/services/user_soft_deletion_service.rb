# frozen_string_literal: true

class UserSoftDeletionService
  def self.call(user_id:)
    new(user_id: user_id).call
  end

  def initialize(user_id:)
    @user = User.find_by(id: user_id)
  end

  def call
    return false unless user.present?

    anonymize_user_data
    user.update!(state: :deleted)

  rescue StandardError => e
    Rails.logger.error "Failed to delete user #{user&.id}: #{e.message}"
    false
  end

  private

  attr_reader :user

  def anonymize_user_data
    deleted_username = "deleted_user_#{user.id}_#{Time.current.to_i}"

    user.update_columns(
      username: deleted_username,
      email: "deleted_#{user.id}_#{Time.current.to_i}@example.com",
      slug: nil,
      avatar_bg_color: "#6b7280"
    )
  end
end
