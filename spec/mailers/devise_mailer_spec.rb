require "rails_helper"

RSpec.describe DeviseMailer, type: :mailer do
  let(:user) { create(:user, email: "test@example.com") }
  let(:token) { "sample_token_123" }

  describe "#confirmation_instructions" do
    let(:mail) { described_class.confirmation_instructions(user, token) }

    it "renders the headers" do
      expect(mail.subject).to eq("discuss² - Confirm your email address")
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq([ "discuss2@atenbi.com" ])
    end

    it "renders the body with verification content" do
      expect(mail.body.encoded).to include("Verify your email address")
      expect(mail.body.encoded).to include("discuss²")
      expect(mail.body.encoded).to include("verification link is only valid for 24 hours")
    end

    it "includes the confirmation token in the verification URL" do
      expect(mail.body.encoded).to include(token)
    end

    context "when user has unconfirmed_email" do
      let(:user) { create(:user, email: "old@example.com", unconfirmed_email: "new@example.com") }

      it "sends to unconfirmed_email" do
        expect(mail.to).to eq([ "new@example.com" ])
      end
    end
  end

  describe "#reset_password_instructions" do
    let(:mail) { described_class.reset_password_instructions(user, token) }

    it "renders the headers" do
      expect(mail.subject).to eq("discuss² - Reset Password Instructions")
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq([ "discuss2@atenbi.com" ])
    end

    it "renders the body with reset content and user email" do
      expect(mail.body.encoded).to include("Reset password instructions")
      expect(mail.body.encoded).to include("Hello #{user.email}!")
      expect(mail.body.encoded).to include("discuss²")
      expect(mail.body.encoded).to include("Change my password")
    end

    it "includes the reset password token in the URL" do
      expect(mail.body.encoded).to include(token)
    end
  end
end
