require "rails_helper"

RSpec.describe "Robots", type: :request do
  describe "robots.txt" do
    context "when not blocking all web crawlers" do
      it "allows all crawlers" do
        allow(Rails.application.credentials).to receive(:disallow_all_web_crawlers).and_return(false)
        get "/robots.txt"

        expect(response.headers["Content-Type"]).to include "text/plain"
        expect(response.body).to include("User-agent: *")
        expect(response.body).to include("Allow: /")
        expect(response.body).to include("Sitemap: http://www.example.com/sitemap.xml.gz")
      end
    end

    context "when blocking all web crawlers" do
      it "blocks all crawlers" do
        allow(Rails.application.credentials).to receive(:disallow_all_web_crawlers).and_return(true)
        get "/robots.txt"

        expect(response.headers["Content-Type"]).to include "text/plain"
        expect(response.body).to include("User-agent: *")
        expect(response.body).to include("Disallow: /")
        expect(response.body).to include("Sitemap: http://www.example.com/sitemap.xml.gz")
      end
    end
  end
end
