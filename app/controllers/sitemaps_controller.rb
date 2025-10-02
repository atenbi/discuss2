class SitemapsController < ApplicationController
  def redirect_to_r2
    r2_url = "#{Rails.application.credentials.cloudflare[:r2_url]}/sitemaps/sitemap.xml.gz"
    redirect_to r2_url, status: :moved_permanently, allow_other_host: true
  end
end
