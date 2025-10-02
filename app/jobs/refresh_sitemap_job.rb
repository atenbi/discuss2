class RefreshSitemapJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Starting sitemap refresh job"

    begin
      SitemapService.build_and_upload_sitemap
      Rails.logger.info "Sitemap refresh completed successfully"
    rescue => e
      Rails.logger.error "Sitemap refresh failed: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e
    end
  end
end
