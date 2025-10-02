module ApplicationHelper
  include Pagy::Frontend

  def flash_message_class(name)
    case name&.to_sym
    when :notice
      "bg-green-100 border border-green-400 text-green-700"
    when :alert
      "bg-red-100 border border-red-400 text-red-700"
    else
      "bg-gray-100 border border-gray-400 text-gray-700"
    end
  end
end
