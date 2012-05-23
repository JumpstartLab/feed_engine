FeedEngine::Application.routes.draw do
  get "subscriptions/create"

  get "sessions/new"
  match 'signup' => 'users#create', as: 'signup'
  match 'signin' => 'sessions#new', as: 'signin'
  match 'login' => 'sessions#create', as: 'login'
  match 'logout' => 'sessions#destroy', as: 'logout'
  match 'current_user' => 'sessions#user', as: 'current_user'

  match 'checkauth/:provider' => 'authentications#check'

  resources :authentications

  match '/dashboard' => 'dashboard#show', as: :user_root
  
  scope module: "api", as: "api", constraints: lambda { |r| r.subdomain == 'api' } do
    resources "feeds" do
      collection do
        scope ":feed_name" do
          resources "posts" do
            match 'refeeds' => "posts#refeed", as: :refeed
          end
        end
      end
    end
  end

  scope "", constraints: lambda { |r| r.subdomain.present? &&
    r.subdomain != 'www' && r.subdomain != 'api' } do
    match 'posts/:display_name', to: "posts#show"
  end

  match 'posts/ind', to: 'posts#ind'
  match 'posts/refeeds' => "posts#refeed", as: :refeed
  resources :subscriptions, only: [:create]

  resources :users
  resources :posts, only: [:create, :index]
  resources :texts
  resources :images
  resources :links

  root :to => 'pages#index'
  match '/integrate' => 'users#integrate', as: 'integrate'

  match '/auth/:provider/callback' => 'authentications#create'
  # html partial fetching
  match '/footer' => 'pages#footer'

end
