FeedEngine::Application.routes.draw do
  root :to => 'feed#show'
  resource :dashboard, :controller => 'dashboard'

  resources :text_items
  resources :link_items
  resources :image_items

  devise_for :users 

  devise_scope :user do 
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  root :to => 'dashboard#show'
end

