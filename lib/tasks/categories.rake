namespace :forum do
  desc "Create categories for the forum"
  task create_categories: :environment do
    categories = {
      "General Discussion" => "#F4C430",
      "Technology & Gadgets" => "#007BFF",
      "Entertainment & Media" => "#FF5733",
      "Lifestyle & Well-being" => "#28A745",
      "Help & Support" => "#6C757D"
    }

    puts "Creating categories..."
    categories.each do |category_name, color|
      Forum::Category.where(name: category_name).first_or_create!(bg_color: color)
      print "."
    end
    puts ""
  end
end
