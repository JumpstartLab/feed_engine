FeedEngine::Application.routes.draw do
  get "subscriptions/create"

  get "sessions/new"
  match 'signup' => 'users#create', as: 'signup'
  match 'signin' => 'sessions#new', as: 'signin'
  match 'login' => 'sessions#create', as: 'login'
  match 'logout' => 'sessions#destroy', as: 'logout'
  match 'current_user' => 'sessions#user', as: 'current_user'
  post 'reset_password' => 'users#reset_password'
  match 'checkauth/:provider' => 'authentications#check'
  match 'pointscount/:id' => 'posts#points_count'

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
    match 'posts/:id', to: "posts#show"
  end

  match 'posts/ind', to: 'posts#ind'
  match 'posts/refeeds' => "posts#refeed", as: :refeed
  resources :subscriptions, only: [:create, :index, :destroy]

  resources :users
  match 'user/update' => 'users#update'
  resources :posts, only: [:create, :index]
  resources :texts
  resources :images
  resources :links

  resources :points, only: [:create]
  resources :posts


  root :to => 'pages#index'
  match '/integrate' => 'users#integrate', as: 'integrate'

  match '/auth/:provider/callback' => 'authentications#create'
  # html partial fetching
  match '/footer' => 'pages#footer'

end
