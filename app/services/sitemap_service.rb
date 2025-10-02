# frozen_string_literal: true

require "aws-sdk-s3"

class SitemapService
  def self.build_and_upload_sitemap
    SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
      Rails.application.credentials.cloudflare[:bucket],
      aws_access_key_id: Rails.application.credentials.cloudflare[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.cloudflare[:secret_access_key],
      aws_region: "auto",
      endpoint: "https://#{Rails.application.credentials.cloudflare[:account_id]}.r2.cloudflarestorage.com"
    )

    SitemapGenerator::Sitemap.default_host = Rails.env.production? ? "https://discuss2.com" : "https://example.com"
    SitemapGenerator::Sitemap.sitemaps_host = "#{Rails.application.credentials.cloudflare[:public_url]}"
    SitemapGenerator::Sitemap.public_path = "tmp/"
    SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
    SitemapGenerator::Sitemap.create_index = :auto
    SitemapGenerator::Sitemap.compress = true

    SitemapGenerator::Sitemap.create do
      add "/", changefreq: "monthly", priority: 1.0
      add "/about", changefreq: "monthly", priority: 0.7
      add "/faq", changefreq: "monthly", priority: 0.7

      Forum::Topic.find_each do |topic|
        add forum_topic_path(topic), lastmod: topic.updated_at, changefreq: "weekly", priority: 0.8
      end
    end
  end
end
