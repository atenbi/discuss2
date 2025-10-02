require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /faq" do
    it "returns http success" do
      get faq_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /privacy_policy" do
    it "returns http success" do
      get privacy_policy_path
      expect(response).to have_http_status(:ok)
    end
  end
end
