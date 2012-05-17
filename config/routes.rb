FeedEngine::Application.routes.draw do
  get "sessions/new"
  match '/signup' => 'users#create', as: 'signup'
  match 'signin' => 'users#signin', as: 'signin'
  resources :authentications

  match '/dashboard' => 'dashboard#show', as: :user_root
  
  scope module: "api", as: "api", constraints: lambda { |r| r.subdomain == 'api' } do
    resources "feeds" do
      collection do
        scope ":user_display_name" do
          resources "posts"
        end
      end
    end
  end

  scope "", constraints: lambda { |r| r.subdomain.present? &&
    r.subdomain != 'www' && r.subdomain != 'api' } do
    match "", to: "users#show" 
    resource "user"
  end
  
  resources :users
  resources :posts, only: [:create, :index]
  resources :texts
  resources :images
  resources :links


  root :to => 'pages#index'
  match '/twitter' => 'users#twitter', as: 'twitter'
  match '/auth/:provider/callback' => 'authentications#create'

  # html partial fetching
  match '/footer' => 'pages#footer'

end
