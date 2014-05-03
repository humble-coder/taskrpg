require 'spec_helper'

feature 'Member updates password' do

	let(:user) { create :user }

  before(:each) do
  	sign_in(user)
  end

	scenario 'successfully' do
		click_link('Edit Info')
		fill_in 'Password', with: 'New Password'
		fill_in 'Password confirmation', with: 'New Password'
		click_button('Update')

		expect(page).to have_content('You have successfully updated your information')
		expect(page).to have_content("User's Domain")
	end

end