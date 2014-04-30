require 'spec_helper'
require 'request_helper'

describe "Tasks (guest users)" do
  describe "GET /tasks for guest user" do
    it "redirects guest user to login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tasks_path
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "POST /tasks for guest user" do
  	it "redirects guest user to login" do

  		post tasks_path, task: {name: "My Task", priority: 1}
  		response.status.should be(302)
      expect(response).to redirect_to("/signin")
  	end
  end

  describe "GET /tasks/1/edit for guest user" do
    it "redirects guest user to login" do

      get edit_task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "GET /tasks/clear for guest user" do
    it "redirects guest user to login" do

      get clear_tasks_path
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "GET /tasks/1/restore for guest user" do
    it "redirects guest user to login" do

      get restore_task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "GET /tasks/1/complete for guest user" do
    it "redirects guest user to login" do

      get complete_task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "GET /tasks/new for guest user" do
    it "redirects guest user to login" do

      get new_task_path
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "PATCH /tasks/1 for guest user" do
    it "redirects guest user to login" do

      patch task_path(1), task: { name: "Updated" }
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "PUT /tasks/1 for guest user" do
    it "redirects guest user to login" do

      put task_path(1), task: { priority: 2 }
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "DELETE /tasks/1 for guest user" do
    it "redirects guest user to login" do

      delete task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end

  describe "GET /tasks/1 for guest user" do
    it "redirects guest user to login" do

      get task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/signin")
    end
  end
end

describe "Tasks (members)" do
  let(:user) { create :user_with_tasks }

  before(:each) do
    login(user)
  end

  describe "GET /tasks for member" do
    it "redirects member to his/her page" do
      get tasks_path
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
    end
  end

  describe "POST /tasks for member" do
    it "creates a task and then redirects member to his/her page" do
      post tasks_path, task: {name: "My Task", priority: 1}

      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
      expect(Task.last.name).to eq("My Task")
    end
  end

  describe "GET /tasks/1/edit for member" do
    it "displays task form for editing" do
      post tasks_path, task: {name: "My Task", priority: 2}

      get edit_task_path(1)
      response.status.should be(200)
    end
  end

  describe "GET /tasks/clear for member" do
    it "deletes member's completed tasks and redirects to his/her page" do

      get clear_tasks_path
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
      expect(User.first.tasks.length).to eq(0)
    end
  end

  describe "GET /tasks/1/restore for member" do
    it "updates task's complete attribute to false" do

      get restore_task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
      expect(Task.first.complete).to eq(false)
    end
  end

  describe "GET /tasks/6/complete for member" do
    it "updates task's complete status to true and then redirects to user's page" do
      post tasks_path, task: {name: "My Task", priority: 2}

      get complete_task_path(6)
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
      expect(Task.all[5].complete).to eq(true)
    end
  end

  describe "GET /tasks/new for member" do
    it "gets new-task form" do

      get new_task_path
      response.status.should be(200)
    end
  end

  describe "PATCH /tasks/1 for member" do
    it "redirects member back to his/her page after updating" do

      patch task_path(1), task: { name: "Updated" }
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
    end
  end

  describe "PUT /tasks/1 for member" do
    it "redirects member back to his/her page after updating" do

      put task_path(1), task: { priority: 2 }
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
    end
  end

  describe "DELETE /tasks/1 for member" do
    it "redirects member back to his/her page after deleting task" do

      delete task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
      expect(user.tasks.length).to eq(4)
    end
  end

  describe "GET /tasks/1 for member" do
    it "redirects member back to his/her page" do

      get task_path(1)
      response.status.should be(302)
      expect(response).to redirect_to("/users/1")
    end
  end
end


