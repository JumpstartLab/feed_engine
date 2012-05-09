module RequestHelpers
  module Signup
    def signup(params)
      fill_in 'Email', :with => params[:email]
      fill_in 'Display Name', :with => params[:display_name]
      fill_in 'Password', :with => params[:password]
      fill_in 'Confirmation', :with => params[:password]
      click_link_or_button 'Sign-Up'
    end
  end
end
