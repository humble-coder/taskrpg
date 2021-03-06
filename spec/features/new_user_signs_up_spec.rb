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
		fill_in 'Password confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Your Stats")
		expect(page).to have_content("Active Tasks")
		expect(page).to have_content("Completed Tasks")
		expect(User.first.options.length).to eq(5)
	end

	scenario 'with blank name' do
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		fill_in 'Password confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Name can't be blank")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

	scenario 'with blank email' do
		fill_in 'Name', with: 'New User'
		fill_in 'Password', with: 'Password'
		fill_in 'Password confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Email can't be blank")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

	scenario 'with blank password' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Password can't be blank Password is too short")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

	scenario 'with blank password confirmation' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Password confirmation doesn't match")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

	scenario 'with mismatching password and password confirmation' do
		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: 'email@example.com'
		fill_in 'Password', with: 'Password'
		fill_in 'Password confirmation', with: 'Password!'
		click_button('Sign Up')

		expect(page).to have_content("Password confirmation doesn't match")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

	scenario 'with email already taken' do
		create(:user)

		fill_in 'Name', with: 'New User'
		fill_in 'Email', with: User.first.email
		fill_in 'Password', with: 'Password'
		fill_in 'Password confirmation', with: 'Password'
		click_button('Sign Up')

		expect(page).to have_content("Email has already been taken")
		expect(page).to have_content("Sign Up")
		expect(page).to have_content("Sign In")
	end

end