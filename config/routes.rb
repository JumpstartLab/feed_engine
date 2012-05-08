Hungrlr::Application.routes.draw do

  resources :growls, :images, :links, :messages
  resource :dashboard
  devise_for :users

>>>>>>> Added basic Devise
  root :to => 'growls#index'
end
