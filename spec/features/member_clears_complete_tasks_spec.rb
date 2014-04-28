require 'spec_helper'

feature 'Member clears complete tasks' do

	let(:user) { create :user_with_tasks }

  before(:each) do
  	sign_in(user)
  end

	scenario 'successfully' do
		click_link('Clear Completed Tasks')

		expect(page).to have_content("Completed tasks were successfully deleted.")
		expect(user.tasks.length).to eq(0)
	end
end