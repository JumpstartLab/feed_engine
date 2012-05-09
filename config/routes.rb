Hungrlr::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
  end

  resources :growls, :images, :links, :messages
  resource :dashboard

  root :to => 'growls#index'

  namespace :api do
      namespace :v1 do
        resources :images
      end
  end

end
