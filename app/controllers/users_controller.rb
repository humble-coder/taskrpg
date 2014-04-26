class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]

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

  def show
    @user = User.includes(:tasks).find(current_user.id)
    @active_tasks = @user.tasks.select { |task| !task.complete }
    @complete_tasks = @user.tasks.select { |task| task.complete }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: "You have successfully registered for Task RPG!" }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "You have successfully updated your profile." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'user was successfully completed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end