require 'spec_helper'

describe PasswordResetController do

	let(:user) { create :user }

	before(:each) do
		ActionMailer::Base.deliveries.clear
	end

	it "sends the email when app makes post request to password_reset with valid email" do
  	post :create, { password_reset: { email: user.email } }
  	password_reset_email = ActionMailer::Base.deliveries.last

  	expect(password_reset_email.subject).to eq("Password Reset")
  	expect(password_reset_email.to).to eq([user.email])
  	expect(password_reset_email.body).to have_content(user.name)
  	expect(password_reset_email.body).to have_content(user.password)
  end

  it "doesn't send the email when wrong email is in params" do
  	post :create, { password_reset: { email: "wrongemail@example.com" } }
  	expect(ActionMailer::Base.deliveries.length).to eq(0)
  end

  it "doesn't send the email when no email is in params" do
  	post :create, { password_reset: { email: "" } }
  	expect(ActionMailer::Base.deliveries.length).to eq(0)
  end
end
