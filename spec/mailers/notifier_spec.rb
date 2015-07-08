require "spec_helper"

describe Notifier do
  let(:user) { create(:user) }

  it "correctly delivers to a user" do
    user.generate_password_reset_token!
    mailer = Notifier.password_reset(user)
    expect(mailer.to).to eq([user.email])
    expect(mailer.subject).to eq("Reset Your Password")
  end
end
