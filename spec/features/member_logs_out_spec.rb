require 'spec_helper'

feature 'Member logs in' do

	let(:user) { create :user }

  before(:each) do
  	visit root_path
  	sign_in(user)
  end

	scenario 'successfully' do
		click_link('Sign Out')
		
		expect(page).to_not have_content(user.email)
		expect(page).to_not have_content('Sign Out')
	end
end