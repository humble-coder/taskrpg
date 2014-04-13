class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_login
    if !signed_in?
      flash[:error] = "You must be logged in to view your tasks."
      redirect_to signin_path
    end
  end
end
