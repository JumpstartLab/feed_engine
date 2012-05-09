Hungrlr::Application.routes.draw do

  devise_for :users

  resources :growls, :images, :links, :messages
  resource :dashboard

  constraints(Subdomain) do
    match '/' => 'growls#show'
  end

  root :to => 'growls#index'
end