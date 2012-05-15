FeedEngine::Application.routes.draw do
  resources :authentications

  match '/dashboard' => 'dashboard#show', as: :user_root
  
  scope module: "api", as: "api", constraints: lambda { |r| r.subdomain == 'api' } do
    resources "feeds" do
      collection do
        scope ":feed_name" do
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

  devise_for :users

  authenticated :user do
    root :to => 'dashboard#show'
  end
  
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => 'sign_in'
  end
  
  resources :users
  resources :posts, only: [:create, :index]
  resources :texts
  resources :images
  resources :links

  match '/sign_up' => 'users#new', as: 'sign_up'
  root :to => 'pages#index'
  match '/twitter' => 'users#twitter', as: 'twitter'
  match '/auth/:provider/callback' => 'authentications#create'

end
