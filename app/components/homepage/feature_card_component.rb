class Homepage::FeatureCardComponent < ViewComponent::Base
  def initialize(feature:)
    @feature = feature
  end

  private

  attr_reader :feature
end
