FeedEngine::Application.routes.draw do
  root :to => 'dashboard#show'
  devise_for :users
  resources :users
  resources :texts
  resources :images
  resources :links
  match '/signup' => 'users#new'
end
