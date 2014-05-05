require 'spec_helper'

feature 'Member resets password' do

	let(:user) { create :user }

  before(:each) do
  	visit root_path
  	click_link('Reset it!')
  end

	scenario 'successfully' do
		fill_in 'Email', with: user.email
		click_button('Reset Password')

		expect(page).to have_content('Check your inbox at ' + user.email + ' for your new password.')
		expect(page).to have_content('Sign in')
	end

	scenario 'with wrong email address' do
		fill_in 'Email', with: 'wrongemail@example.com'
		click_button('Reset Password')

		expect(page).to have_content('No account with that email exists.')
		expect(page).to have_content('Password Reset')
	end

	scenario 'with no email address' do
		fill_in 'Email', with: ''
		click_button('Reset Password')

		expect(page).to have_content('Please enter an email address.')
		expect(page).to have_content('Password Reset')
	end

end