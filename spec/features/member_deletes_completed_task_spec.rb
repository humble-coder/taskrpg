require 'spec_helper'

feature 'Member completes task' do

	let(:task) { create :task }

  before(:each) do
  	sign_in(task.user)
  end

	scenario 'successfully' do
		click_link('Complete')
		click_link('Get Exp')

		expect(task.user.tasks.length).to eq(0)
	end
end