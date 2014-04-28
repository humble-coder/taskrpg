require 'spec_helper'

feature 'Member logs in' do

	let(:user) { create :user }

  before(:each) do
  	visit root_path
  end

	scenario 'successfully' do
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button('Sign in')

		expect(page).to have_content("Your Stats")
		expect(page).to have_content("Active Tasks")
		expect(page).to have_content("Completed Tasks")
		expect(user.remember_token).to_not eq("")
	end

	scenario 'without email' do
		fill_in 'Password', with: user.password
		click_button('Sign in')

		expect(page).to have_content("Invalid email-password combination")
		expect(page).to_not have_content("Your Stats")
		expect(page).to_not have_content("Active Tasks")
		expect(page).to_not have_content("Completed Tasks")
	end

	scenario 'without password' do
		fill_in 'Email', with: user.email
		click_button('Sign in')

		expect(page).to have_content("Invalid email-password combination")
		expect(page).to_not have_content("Your Stats")
		expect(page).to_not have_content("Active Tasks")
		expect(page).to_not have_content("Completed Tasks")
	end

	scenario 'with neither email nor password' do
	  click_button('Sign in')

	  expect(page).to have_content("Invalid email-password combination")
		expect(page).to_not have_content("Your Stats")
		expect(page).to_not have_content("Active Tasks")
		expect(page).to_not have_content("Completed Tasks")
	end
end