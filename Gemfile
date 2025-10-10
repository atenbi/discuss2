source "https://rubygems.org"
ruby "3.3.6"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache", "~> 1.0.8"
gem "solid_queue", "~> 1.0.2"
gem "solid_cable"
gem "bootsnap", require: false
gem "thruster", require: false
gem "slim-rails", "~> 3.6.3"
gem "friendly_id", "~> 5.5"
gem "devise"
gem "omniauth-google-oauth2", "~> 1.2.1"
gem "omniauth-rails_csrf_protection"
gem "pagy", "~> 9.3"
gem "view_component"
gem "ransack"
gem "rdiscount", "~> 2.2" # Used in MarkdownHelper
gem "faker"
gem "kamal", require: false
gem "inline_svg"
gem "invisible_captcha"
gem "rolify"
gem "pundit"
gem "premailer-rails"
gem "sitemap_generator"
gem "aws-sdk-s3", "~> 1.176", ">= 1.176.1", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "bullet"
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "rails_live_reload"
  gem "annotaterb"
  gem "pry-rails"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "pry-rails"
  gem "simplecov", require: false
end
