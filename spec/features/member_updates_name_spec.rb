require 'spec_helper'

feature 'Member updates name' do

	let(:user) { create :user }

  before(:each) do
  	sign_in(user)
  end

	scenario 'successfully' do
		click_link('Edit Info')
		fill_in 'Name', with: 'New Name'
		click_button('Update')

		expect(page).to have_content("You have successfully updated your information")
		expect(page).to have_content("New Name's Domain")
		expect(User.find(user.id).name).to eq('New Name')
	end

	scenario 'without filling in name' do
		click_link('Edit Info')
		fill_in 'Name', with: ''
		click_button('Update')

		expect(page).to have_content('Edit Your Info')
		expect(page).to have_content("Name can't be blank")
		expect(user.name).to_not eq('New Name')
	end

end