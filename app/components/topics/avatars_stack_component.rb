# frozen_string_literal: true

module Topics
  class AvatarsStackComponent < ViewComponent::Base
    include UsersHelper

    attr_reader :users_arr

    def initialize(users_arr:)
      @users_arr = users_arr
    end

    private

    def render?
      users_arr.present?
    end
  end
end
