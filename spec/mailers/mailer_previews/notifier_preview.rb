class NotifierPreview < ActionMailer::Preview
  def password_reset
    user = User.create(first_name: "Jason", last_name: "Seifer", email: "jason1234@teamtreehouse.com", password: "treehouse1", password_confirmation: "treehouse1")
    user.generate_password_reset_token!
    mailer = Notifier.password_reset(user)
    user.destroy
    mailer
  end
end
