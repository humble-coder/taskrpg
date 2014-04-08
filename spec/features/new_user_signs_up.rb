require 'spec_helper'

feature 'User signs up' do

  before(:each) do
  	visit root_path
  	click_link 'Sign up today!'
  end

	scenario 'successfully' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		fill_in 'Confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("New User's Tasks")
	end

	scenario 'with blank name' do
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		fill_in 'Password Confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Name can't be blank")
	end

	scenario 'with blank password' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password Confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Passwords don't match")
	end

	scenario 'with blank password confirmation' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Passwords don't match")
	end

	scenario 'with mismatching password and password confirmation' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		fill_in 'Password Confirmation', with: 'Password!'
		click_button('Sign Up')

		expect(page).to have_content("Passwords don't match")
	end

end