FeedEngine::Application.routes.draw do

  devise_for :users 

  devise_scope :user do 
    get "signup" => "devise/registrations#new", :as => :new_user
  end


  root :to => "home#index"

  end
