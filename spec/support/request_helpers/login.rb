module RequestHelpers
  module Login
    def login(params)
      fill_in 'Email', :with => params[:email]
      fill_in 'Password', :with => params[:password]
      click_link_or_button 'Sign-In'
    end
  end
end
