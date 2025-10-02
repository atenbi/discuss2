require "rails_helper"

RSpec.describe RefreshSitemapJob, type: :job do
  describe "#perform" do
    let(:job) { described_class.new }

    before do
      allow(Rails.logger).to receive(:info)
      allow(Rails.logger).to receive(:error)
    end

    context "when sitemap generation succeeds" do
      before do
        allow(SitemapService).to receive(:build_and_upload_sitemap)
      end

      it "calls SitemapService.build_and_upload_sitemap" do
        job.perform

        expect(SitemapService).to have_received(:build_and_upload_sitemap)
      end

      it "logs success messages" do
        job.perform

        expect(Rails.logger).to have_received(:info).with("Starting sitemap refresh job")
        expect(Rails.logger).to have_received(:info).with("Sitemap refresh completed successfully")
      end
    end

    context "when sitemap generation fails" do
      let(:error_message) { "S3 connection failed" }
      let(:error) { StandardError.new(error_message) }

      before do
        allow(error).to receive(:backtrace).and_return([ "line 1", "line 2" ])
        allow(SitemapService).to receive(:build_and_upload_sitemap).and_raise(error)
      end

      it "logs error messages" do
        expect { job.perform }.to raise_error(StandardError, error_message)

        expect(Rails.logger).to have_received(:info).with("Starting sitemap refresh job")
        expect(Rails.logger).to have_received(:error).with("Sitemap refresh failed: #{error_message}")
        expect(Rails.logger).to have_received(:error).with("line 1\nline 2")
      end

      it "re-raises the original error" do
        expect { job.perform }.to raise_error(StandardError, error_message)
      end
    end
  end

  describe "job configuration" do
    it "is queued on the default queue" do
      expect(described_class.queue_name).to eq("default")
    end
  end
end
