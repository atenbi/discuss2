require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "sitemap.xml.gz" do
    context "when redirecting to R2" do
      it "redirects to cloudflare R2 sitemap" do
        allow(Rails.application.credentials).to receive(:cloudflare).and_return(
          { r2_url: "https://example.r2.cloudflarestorage.com" }
        )

        get "/sitemap.xml.gz"

        expect(response).to have_http_status(:moved_permanently)
        expect(response).to redirect_to("https://example.r2.cloudflarestorage.com/sitemaps/sitemap.xml.gz")
      end
    end
  end
end
