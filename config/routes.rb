Hungrlr::Application.routes.draw do
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

  constraints(Subdomain) do
    constraints :subdomain => 'api' do
      scope module: "api" do
        namespace "v1" do
          match '/feeds/:display_name' => 'feeds#show'  , :via => :get
          match '/feeds/:display_name' => 'feeds#create', :via => :post
          # resources :feeds
          resources :meta_data, :only => [ :create ]
        end
      end
    end
    match '/' => 'growls#index'
  end

  root :to => 'pages#home'
end
