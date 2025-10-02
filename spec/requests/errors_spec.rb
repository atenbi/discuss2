require 'rails_helper'

RSpec.describe "Errors", type: :request do
  describe "GET /404" do
    it "returns 404 status" do
      get "/404"
      expect(response).to have_http_status(:not_found)
    end

    it "renders the not_found template" do
      get "/404"
      expect(response.body).to include("Page not found")
    end
  end

  describe "GET /500" do
    it "returns 500 status" do
      get "/500"
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
