require 'spec_helper'

feature 'Member updates email' do

	let(:user) { create :user }

  before(:each) do
  	sign_in(user)
  end

	scenario 'successfully' do
		click_link('Edit Info')
		fill_in 'Email', with: 'newemail@example.com'
		click_button('Update')

		expect(page).to have_content('You have successfully updated your information')
		expect(page).to have_content('newemail@example.com')
		expect(User.find(user.id).email).to eq('newemail@example.com')
	end

	scenario 'without filling in email' do
		click_link('Edit Info')
		fill_in 'Email', with: ''
		click_button('Update')

		expect(page).to have_content('Edit Your Info')
		expect(page).to have_content("Email can't be blank")
	end

end