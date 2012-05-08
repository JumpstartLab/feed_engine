Hungrlr::Application.routes.draw do

  resources :growls, :images, :links, :messages
  resource :dashboard
  devise_for :users

  root :to => 'growls#index'
end
