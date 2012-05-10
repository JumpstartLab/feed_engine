Hungrlr::Application.routes.draw do
  match "/home" => "pages#home"

  devise_for :users

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login' => 'devise/sessions#new'
  end

  resources :growls, :images, :links, :messages
  resource :dashboard

  namespace :api do
      namespace :v1 do
        resources :images
        resources :meta_data
      end
  end

  constraints(Subdomain) do
    match '/' => 'growls#show'
  end

  root :to => 'pages#home'
end
