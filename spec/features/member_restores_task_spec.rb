require 'spec_helper'

feature 'Member restores task' do

	let(:task) { create :complete_task }

  before(:each) do
  	sign_in(task.user)
  end

	scenario 'successfully' do
		click_link('Restore')

		expect(page).to have_content('Task was successfully restored.')
	end
end