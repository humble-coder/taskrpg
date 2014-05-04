class PasswordResetController < ApplicationController

	def create
		user = User.find_by(email: params[:password_reset][:email].downcase)
		if user
			new_password = Array.new(6){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
			user.update_attribute(:password, new_password)
			user.update_attribute(:password_confirmation, new_password)
			UserMailer.password_reset(user).deliver
			redirect_to(signin_path, notice: 'Check your email for your new (temporary) password.')
		else
			flash.now[:error] = 'No account with that email exists.'
		end
	end

end
