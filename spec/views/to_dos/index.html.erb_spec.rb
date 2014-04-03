require 'spec_helper'

describe "to_dos/index" do
  before(:each) do
    assign(:to_dos, [
      stub_model(ToDo,
        :name => "MyText",
        :priority => 1
      ),
      stub_model(ToDo,
        :name => "MyText",
        :priority => 1
      )
    ])
  end

  it "renders a list of to_dos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
