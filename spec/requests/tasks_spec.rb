require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    it "returns a successful response" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tasks_path
      response.status.should be(200)
    end
  end
end
