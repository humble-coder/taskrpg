require 'spec_helper'

feature 'Member completes task' do

	let(:task) { create :task }

  before(:each) do
  	sign_in(task.user)
  end

	scenario 'successfully' do
		click_link('Complete')

		expect(page).to have_content('Task was successfully completed.')
		expect(page).to have_content('Some Task Priority: 1')
	end
end