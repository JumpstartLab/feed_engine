module UserSupport
  module Login
    def login(user)
      visit login_path
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => 'hungry'
      within(".actions") do
        click_on 'Sign in'
      end
    end
  end
end