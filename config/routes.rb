FeedEngine::Application.routes.draw do
  resources :messages
  resources :images
  resources :users
  resources :sessions
  resources :links
  resources :posts
  resource  :dashboard, 
            :controller => "dashboard", 
            :only => "show"

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  constraints(Subdomain) do
    match "/" => "users#show"
  end
  
  root to: "home#index"
end
