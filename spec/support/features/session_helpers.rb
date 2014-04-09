module Features
  module SessionHelpers
    def sign_in(user = nil)
    	if(!user)
      	user = create(:user)
      end
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Sign in')
    end
  end
end