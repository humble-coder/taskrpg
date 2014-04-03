require 'spec_helper'

describe "to_dos/new" do
  before(:each) do
    assign(:to_do, stub_model(ToDo,
      :name => "MyText",
      :priority => 1
    ).as_new_record)
  end

  it "renders new to_do form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", to_dos_path, "post" do
      assert_select "textarea#to_do_name[name=?]", "to_do[name]"
      assert_select "input#to_do_priority[name=?]", "to_do[priority]"
    end
  end
end
