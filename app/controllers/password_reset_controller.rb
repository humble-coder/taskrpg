class PasswordResetController < ApplicationController

	def create
		user = User.find_by(email: params[:password_reset][:email].downcase)
		if user
			new_password = Array.new(10){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
			user.update_attribute(:password, new_password)
			user.update_attribute(:password_confirmation, new_password)
			UserMailer.password_reset(user).deliver
			redirect_to(signin_path, notice: 'Check your inbox at ' + user.email + ' for your new password.')
		elsif params[:password_reset][:email].empty?
			flash.now[:error] = "Please enter an email address."
			render 'new'
		else
			flash.now[:error] = 'No account with that email exists.'
			render 'new'
		end
	end

end
