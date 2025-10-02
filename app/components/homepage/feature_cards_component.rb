class Homepage::FeatureCardsComponent < ViewComponent::Base
  def initialize(features:)
    @features = features
  end

  private

  attr_reader :features
end
