FeedEngine::Application.routes.draw do
  match '/dashboard' => 'dashboard#show'
  authenticated :user do
    root :to => 'dashboard#show'
  end
  root :to => 'pages#index'

  devise_for :users
  resources :posts, only: [:create, :index]
  resources :users
  resources :texts
  resources :images
  resources :links
  match '/signup' => 'users#new'
end
