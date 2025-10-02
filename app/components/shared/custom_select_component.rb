# frozen_string_literal: true

module Shared
  class CustomSelectComponent < ViewComponent::Base
    attr_reader :label, :aria_label, :items, :default_item, :form_name, :selected_slug_or_id, :css_width, :show_remove_filter

    delegate :render_custom_select_item, to: :helpers

    def initialize(label: nil, aria_label: nil, form_name:, items: [], default_item:, selected_slug_or_id: nil, css_width: "w-full", show_remove_filter: false, arrow_icon: "keyboard_arrow_right", open_arrow_icon: "keyboard_arrow_down", auto_submit: false)
      @label = label
      @aria_label = aria_label
      @form_name = form_name
      @items = items
      @default_item = default_item
      @selected_slug_or_id = selected_slug_or_id
      @css_width = css_width
      @show_remove_filter = show_remove_filter
      @arrow_icon = arrow_icon
      @open_arrow_icon = open_arrow_icon
      @auto_submit = auto_submit
    end

    def selected_label
      return default_item.label if selected_slug_or_id.blank?

      selected_item = items.find { |item| item.slug_or_id.to_s == selected_slug_or_id.to_s }
      selected_item ? selected_item.label : default_item.label
    end

    def choose_action
      @auto_submit ? "chooseAndSubmit" : "choose"
    end

    def self.category_items(default_label: "Please select", slug_or_id: :slug)
      default_item = Item.new("", default_label)
      items = Forum::Category.all.map do |category|
        Item.new(category.send(slug_or_id), category.name, category.bg_color)
      end
      { default_item: default_item, items: items }
    end

    class Item < Struct.new(:slug_or_id, :label, :color); end
  end
end
