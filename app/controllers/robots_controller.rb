class RobotsController < ApplicationController
  def show
    sitemap_host = request.base_url
    content = <<~ROBOTS
			User-agent: *
			#{disallow_all_crawlers? ? 'Disallow: /' : 'Allow: /'}

			Sitemap: #{sitemap_host}/sitemap.xml.gz
    ROBOTS

    render plain: content, content_type: "text/plain"
  end

  private

  def disallow_all_crawlers?
    Rails.application.credentials.disallow_all_web_crawlers
  end
end
