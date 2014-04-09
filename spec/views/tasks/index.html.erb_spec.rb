# require 'spec_helper'

# describe "tasks/index" do
#   let(:user) { create(:user) }

#   before(:each) do
#     assign(:tasks, [
#       stub_model(Task,
#         :name => "My Task",
#         :priority => 1,
#         :user => user
#       ),
#       stub_model(Task,
#         :name => "Another Task",
#         :priority => 2,
#         :user => user
#       )
#     ])
#   end

#   it "renders a list of tasks" do
#     render

#     # Run the generator again with the --webrat flag if you want to use webrat matchers
#     assert_select "ul" do |elements|
#       elements.each do |element|
#         assert_select element, "li", 2
#       end
#     end
    
#   end
# end
