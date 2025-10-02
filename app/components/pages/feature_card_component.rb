module Pages
  class FeatureCardComponent < ViewComponent::Base
    def initialize(title:, description:)
      @title = title
      @description = description
    end

    attr_reader :title, :description
  end
end
