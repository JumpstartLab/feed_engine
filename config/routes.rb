Hungrlr::Application.routes.draw do

  devise_for :users

  resources :growls, :images, :links, :messages
  resource :dashboard


  root :to => 'growls#index'
end
