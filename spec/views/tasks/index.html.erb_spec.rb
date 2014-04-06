require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :name => "MyText",
        :priority => 1
      ),
      stub_model(Task,
        :name => "MyText",
        :priority => 2
      )
    ])
  end

  it "renders a list of tasks" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul" do |elements|
      elements.each do |element|
        assert_select element, "li", 2
      end
    end
    
  end
end
