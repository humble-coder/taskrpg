require 'spec_helper'

feature 'User creates a todo' do

  before(:each) do
  	visit root_path
  end

	scenario 'successfully' do
		click_link 'New Task'

		fill_in 'Name', with: 'My To-Do'
		page.select '1', :from => 'Priority'
		click_button('Create Task')

		expect(page).to have_content('My To-Do Priority: 1')
	end
end