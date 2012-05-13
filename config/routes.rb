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
  # resources :images, :links, :messages, :authentications

  resource :dashboard, :only => [ :show ]

  namespace :api do
    namespace :v1 do
<<<<<<< HEAD
      resources :images
      resources :meta_data
=======
      scope ':display_name', :as => "user" do
        resources :growls, :only => [ :index, :create ]
        resources :meta_data, :only => [ :create ]
      end
>>>>>>> 362f555744dd7cf11e08388cc0c92d20bc1fe4ae
    end
  end

  constraints(Subdomain) do
    constraints :subdomain => 'api' do
      scope module: "api" do
        namespace "v1" do
          resources :feeds
        end
      end
    end
    match '/' => 'growls#show'
  end

  root :to => 'pages#home'
end
