Hungrlr::Application.routes.draw do

  devise_for :users

  resources :growls, :images, :links, :messages
  resource :dashboard


  root :to => 'growls#index'

  namespace :api do
      namespace :v1 do
        resources :images
      end
  end

end
