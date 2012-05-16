Hungrlr::Application.routes.draw do
  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  scope module: "api" do
    namespace "v1" do
      get '/feeds/:display_name' => 'feeds#show'
      post '/feeds/:display_name' => 'feeds#create'
      resources :user_tweets, only: [:create, :index]
      resources :meta_data, :only => [ :create ]
      get '/users/twitter' => 'users#twitter'
    end
  end

  namespace "api" do
    namespace "v1" do
      # get '/feeds/:display_name' => 'feeds#show'
      # post '/feeds/:display_name' => 'feeds#create'
      # resources :user_tweets, only: [:create]
      # resources :users, only: [:index]
      resources :meta_data, only: [ :create ]
    end
  end

  constraints(Subdomain) do
    constraints :subdomain => 'api' do ## For external use
      scope module: "api" do
        namespace "v1" do
          get '/feeds/:display_name' => 'feeds#show'
          post '/feeds/:display_name' => 'feeds#create'
          resources :user_tweets, only: [:create, :index]
          resources :meta_data, :only => [ :create ]
        end
      end
    end
    match '/' => 'growls#index'
    # match '*' => "growls#index"
  end
  match "/home" => "pages#home"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/auth/:provider/callback' => 'authentications#create'

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login' => 'devise/sessions#new'
  end

  resources :growls, :only => [ :show, :create ]
  resources :authentications, :only => [ :new ]
  resources :images, :links, :messages, :authentications
  resource :dashboard, :only => [ :show ]
  
  root :to => 'pages#home'
end
