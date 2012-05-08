Hungrlr::Application.routes.draw do

  resources :growls, :images, :links, :messages
  resource :dashboard
  root :to => 'growls#index'
end
