require "rails_helper"

RSpec.describe "Forum::Tags", type: :request do
  describe "GET /forum/tags" do
    it "returns http success" do
      get forum_tags_path
      expect(response).to have_http_status(:ok)
    end
  end
end
