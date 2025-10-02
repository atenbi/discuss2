# frozen_string_literal: true

module Profile
  class HeaderComponent < ViewComponent::Base
    attr_reader :user

    def initialize(user:)
      @user = user
    end
  end
end
