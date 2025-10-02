class DeviseMailer < Devise::Mailer
  layout "mailer"
  default from: "discuss2@atenbi.com"

  def confirmation_instructions(record, token, opts = {})
    @resource = record
    @token = token

    mail(
      to: record.unconfirmed_email || record.email,
      subject: "discuss² - Confirm your email address"
    ) do |format|
      format.html
    end
  end

  def reset_password_instructions(record, token, opts = {})
    @resource = record
    @token = token

    mail(
      to: record.email,
      subject: "discuss² - Reset Password Instructions"
    ) do |format|
      format.html
    end
  end
end
