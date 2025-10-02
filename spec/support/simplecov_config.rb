require "simplecov"

SimpleCov.start "rails" do
  add_filter do |source_file|
    source_file.lines.count < 5
  end

  add_filter "app/components/homepage/feature_cards_component.rb"
  add_filter "app/controllers/users/omniauth_callbacks_controller.rb"
  add_filter "app/models/user.rb"
  add_filter "app/models/role.rb"
  add_filter "app/policies/application_policy.rb"
  add_filter "app/services/sitemap_service.rb"

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Components", "app/components"
  add_group "Finders", "app/finders"
  add_group "Services", "app/services"
  add_group "Helpers", "app/helpers"
  add_group "Mailers", "app/mailers"
  add_group "Jobs", "app/jobs"
  add_group "Policies", "app/policies"
end
