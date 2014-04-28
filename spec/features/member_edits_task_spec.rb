require 'spec_helper'

feature 'Member edits task' do

	let(:task) { create :task }

  before(:each) do
  	sign_in(task.user)
  	click_link('Edit')
  end

	scenario 'successfully (task name)' do
		fill_in 'Name', with: 'Updated Task'
		click_button('Update Task')

		expect(page).to have_content('Task was successfully updated.')
		expect(page).to have_content('Updated Task Priority: 1')
		expect(page).to have_content("User 's Domain")
	end

	scenario 'successfully (task priority)' do
		page.select '3', :from => 'Priority'
		click_button('Update Task')

		expect(page).to have_content('Task was successfully updated.')
		expect(page).to have_content('Some Task Priority: 3')
		expect(page).to have_content("User 's Domain")
	end

	scenario 'without a name' do
		fill_in 'Name', with: ''
		click_button('Update Task')

		expect(page).to have_content("Name can't be blank")
		expect(page).to_not have_content("User 's Domain")
	end
end