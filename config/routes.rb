FeedEngine::Application.routes.draw do
  resources :messages

  resources :images

  resources :links

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :sessions

  root to: "home#index"

  resources :posts
  resource :dashboard, :controller => "dashboard", :only => "show"

  resources :subscriptions
end
