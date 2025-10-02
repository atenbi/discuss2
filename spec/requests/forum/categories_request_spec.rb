require "rails_helper"

RSpec.describe "Forum::Categories", type: :request do
  describe "GET /forum/categories" do
    it "returns http success" do
      get forum_categories_path
      expect(response).to have_http_status(:success)
    end
  end
end
