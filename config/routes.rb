Hungrlr::Application.routes.draw do
  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  namespace "api" do ## Used for Ajax purposes
    namespace "v1" do
      resources :meta_data, only: [ :create ]
      post '/feeds/:display_name/growls/:id/refeed' => 'feeds#refeed'
    end
  end
  constraints(Subdomain) do
    constraints :subdomain => 'api' do ## For external use
      scope module: "api" do
        namespace "v1" do
          get '/users/twitter' => 'users#twitter'
          get '/feeds/:display_name' => 'feeds#show'
          post '/feeds/:display_name' => 'feeds#create'
          post '/feeds/:display_name/growls/:id/refeed' => 'feeds#refeed'
          resources :user_tweets, only: [:create, :index]
          resources :meta_data, :only => [ :create ]
        end
      end
    end
    match '/' => 'growls#index'
  end
  match "/home" => "pages#home"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/auth/:provider/callback' => 'authentications#create'

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login' => 'devise/sessions#new'
  end

  resources :growls, :only => [ :show, :create ]
  resources :regrowled, only: [:create]
  resources :authentications, :only => [ :new ]
  resources :images, :links, :messages, :authentications
  resource :dashboard, :only => [ :show ]

  root :to => 'pages#home'
end
