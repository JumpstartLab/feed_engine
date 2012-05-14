Hungrlr::Application.routes.draw do

  scope module: "api" do
    namespace "v1" do
      get '/feeds/:display_name' => 'feeds#show'
      post '/feeds/:display_name' => 'feeds#create'
      # resources :feeds
      resources :meta_data, :only => [ :create ]
    end
  end
  constraints(Subdomain) do
    constraints :subdomain => 'api' do ## For external use
      scope module: "api" do
        namespace "v1" do
          get '/feeds/:display_name' => 'feeds#show'
          post '/feeds/:display_name' => 'feeds#create'
          # resources :feeds
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
