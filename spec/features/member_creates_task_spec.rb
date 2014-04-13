require 'spec_helper'

feature 'Member creates task' do

	let(:user) { create :user }

  before(:each) do
  	sign_in(user)
  	click_link 'New Task'
  end

	scenario 'successfully' do
		fill_in 'Name', with: 'My Task'
		page.select '1', :from => 'Priority'
		click_button('Create Task')

		expect(page).to have_content('My Task Priority: 1')
	end

	scenario 'without filling in name of task' do
		page.select '2', :from => 'Priority'
		click_button('Create Task')

		expect(page).to have_content("Name can't be blank")
		expect(page).to_not have_content('Priority: 2')
	end
end