# frozen_string_literal: true

module Shared
  class AvatarComponent < ViewComponent::Base
    attr_reader :username, :bg_color, :width, :height, :font_size

    def initialize(username:, bg_color:, width: "40px", height: "40px", font_size: "18px")
      @username = username
      @bg_color = bg_color
      @width = width
      @height = height
      @font_size = font_size
    end

    private

    def render?
      username.present? && bg_color.present?
    end

    def first_letter
      username.first.upcase
    end
  end
end
