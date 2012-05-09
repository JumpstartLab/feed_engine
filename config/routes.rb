Hungrlr::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
  end

  resources :growls, :images, :links, :messages
  resource :dashboard

<<<<<<< HEAD
  root :to => 'growls#index'

  namespace :api do
      namespace :v1 do
        resources :images
      end
  end

end
=======
  constraints(Subdomain) do
    match '/' => 'growls#show'
  end

  root :to => 'growls#index'
end
>>>>>>> a1491f2329a12a138ce80730db0f3fff9e32fe7c
