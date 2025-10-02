namespace :forum do
  desc "Create tags for the forum"
  task create_tags: :environment do
    tags = [
      "Off-Topic",
      "Introductions",
      "News & Trends",
      "Opinions & Debates",
      "Events & Announcements",
      "Smartphones",
      "Laptops & PCs",
      "Software & Apps",
      "Hardware & Upgrades",
      "Cybersecurity",
      "Movies & TV Shows",
      "Gaming",
      "Music & Podcasts",
      "Books & Comics",
      "Streaming & Platforms",
      "Fitness & Exercise",
      "Health & Nutrition",
      "Travel & Adventure",
      "Home & Living",
      "Career & Productivity",
      "Troubleshooting",
      "Bug Reports",
      "How-To Guides",
      "Tech Support",
      "Ask the Community"
    ]

    puts "Creating tags..."
    tags.each do |tag_name|
      Forum::Tag.where(name: tag_name).first_or_create!
      print "."
    end
    puts ""
  end
end
