FeedEngine::Application.routes.draw do
 

  root :to => 'feed#show'

  match 'users/auth/:provider' => 'authentications#new'
  match 'users/auth/:provider/callback' => 'authentications#create'
  
  resources :authentications
  resource :dashboard, :controller => 'dashboard'

  resources :text_items
  resources :link_items
  resources :image_items
  resources :external_accounts

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  devise_scope :user do 
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end
end

