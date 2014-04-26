class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:edit, :update, :complete, :restore, :destroy]

  def index
    respond_to do |format|
      if signed_in?
        format.html { redirect_to current_user }
        format.json { render action: 'show', status: :ok, location: current_user }
      else
        format.html { redirect_to sign_in }
        format.json { redirect_to sign_in }
      end
    end
  end

  def new
    @task = Task.new
    @options = []
    current_user.options.each do |option|
      @options << option.value
    end
  end

  def edit
  end

  def create
    @task = current_user.tasks.create(task_params)
    current_user.options.each do |option|
      option.destroy if option.value == @task.priority
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to current_user, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: current_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to current_user, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def clear
    @tasks = Task.where('user_id = ? AND complete = ?', current_user.id, true)
    @tasks.destroy_all

    respond_to do |format|
      if @tasks.destroy_all
        format.html { redirect_to current_user, notice: "Completed tasks were successfully deleted." }
        format.json { head :no_content }
      else
        format.html { render current_user, notice: "Unable to clear tasks. Please try again." }
        format.json { render action: 'show', status: :unprocessable_entity, location: current_user }
      end
    end
  end

  def complete
    @task.update(complete: true)

    respond_to do |format|
      if @task.complete
        format.html { redirect_to current_user, notice: 'Task was successfully completed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to current_user, notice: 'Unable to mark task as complete. Please try again.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def restore
    @task.update(complete: false)

    respond_to do |format|
      if !@task.complete
        format.html { redirect_to current_user, notice: 'Task was successfully restored.' }
        format.json { head :no_content }
      else
        format.html { redirect_to current_user, notice: 'Unable to mark task as active. Please try again.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.user.options.create(value: @task.priority)
    @task.destroy

    respond_to do |format|
      if current_user.level_up?
        format.html { redirect_to current_user, notice: 'Task was successfully deleted. And you leveled up!' }
        format.json { head :no_content }
      else
        format.html { redirect_to current_user, notice: 'Task was successfully deleted. And you gained 100 exp!' }
        format.json { head :no_content }
      end
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:name, :priority)
    end
end
