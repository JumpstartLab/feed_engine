Hungrlr::Application.routes.draw do

  devise_for :users

  resources :growls, :images, :links, :messages
  resource :dashboard

  match '/' => 'growls#show', :constraints => { :subdomain => /.+/ }
  root :to => 'growls#index'
end