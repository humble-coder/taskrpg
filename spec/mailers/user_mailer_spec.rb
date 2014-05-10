require "spec_helper"

describe UserMailer do

	let(:user) { create :user }
  let(:email) { UserMailer.password_reset(user).deliver }

  it "has a from address of admin@task.rpg" do
  	expect(email.to).to eq([user.email])
  	expect(email.from).to eq(["admin@taskrpg.com"])
  	expect(email.subject).to eq("Password Reset")
  	expect(ActionMailer::Base.deliveries.empty?).to eq(false)
  	expect(email.body).to have_content(user.name)
  	expect(email.body).to have_content(user.password)
  end

end
