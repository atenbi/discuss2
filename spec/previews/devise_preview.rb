class DeviseMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/devise_mailer/confirmation_instructions
  def confirmation_instructions
    DeviseMailer.confirmation_instructions(User.first, "faketoken")
  end

  # Preview this email at http://localhost:3000/rails/mailers/devise_mailer/reset_password_instructions
  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.first, "faketoken")
  end
end
