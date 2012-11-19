module UserSupport
  module Login
    def login(user)
      visit new_user_session_path
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => 'hungry'
      within(".actions") do
        click_on 'Sign in'
      end
    end
  end
  module Logout
    def logout()
      click_on "Sign out"
    end
  end
end
