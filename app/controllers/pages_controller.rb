require "ostruct"

class PagesController < ApplicationController
  layout "homepage/main", only: [ :home, :privacy_policy ]

  def home
    @features = home_features_data
  end

  def privacy_policy; end

  def about
    @features = about_features_data
  end

  def faq; end

  private

  def home_features_data
    [
      OpenStruct.new(
        img_url: "backgrounds/homepage/pen-in-hand.png",
        title: "Built for Communities",
        description: "Threaded discussions, categories, tags, mentions, reactions, moderation tools - everything you need to foster meaningful engagement."
      ),
      OpenStruct.new(
        img_url: "backgrounds/homepage/motion-train.png",
        title: "Fast & Flexible",
        description: "Lightweight, responsive, and easy to customize. discuss² is made for both speed and extensibility."
      ),
      OpenStruct.new(
        img_url: "backgrounds/homepage/programming-abstract.png",
        title: "Open Source & Self-Hostable",
        description: "Fully open source under the MIT license. Run it on your own server, modify it freely, and make it your own."
      )
    ]
  end

  def about_features_data
    [
      {
        title: "Modern, Minimal UI",
        description: "A user-friendly layout that gets out of the way and lets conversations shine."
      },
      {
        title: "Built for Communities",
        description: "Threaded discussions, categories, tags, mentions, reactions, moderation tools - everything you need to foster meaningful engagement."
      },
      {
        title: "Fast & Flexible",
        description: "Lightweight, responsive, and easy to customize. discuss² is made for both speed and extensibility."
      },
      {
        title: "Open Source & Self-Hostable",
        description: "Fully open source under the MIT license. Run it on your own server, modify it freely, and make it your own."
      }
    ]
  end
end
