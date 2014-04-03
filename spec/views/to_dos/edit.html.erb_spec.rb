require 'spec_helper'

describe "to_dos/edit" do
  before(:each) do
    @to_do = assign(:to_do, stub_model(ToDo,
      :name => "MyText",
      :priority => 1
    ))
  end

  it "renders the edit to_do form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", to_do_path(@to_do), "post" do
      assert_select "textarea#to_do_name[name=?]", "to_do[name]"
      assert_select "input#to_do_priority[name=?]", "to_do[priority]"
    end
  end
end
