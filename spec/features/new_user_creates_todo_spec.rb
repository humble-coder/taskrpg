require 'spec_helper'

feature 'User creates a todo' do

  before(:each) do
  	visit root_path
  end

	scenario 'successfully' do
		click_link 'New To-Do'

		fill_in 'Content', with: 'My To-Do'
		page.select '1', :from => 'Priority'
		click_button('Save To-Do')

		expect(page).to have_content('My To-Do 1')
	end
end