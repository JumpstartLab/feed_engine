FeedEngine::Application.routes.draw do
  match '/dashboard' => 'dashboard#show', as: :user_root
  
  scope "", constraints: lambda { |r| r.subdomain.present? && r.subdomain == 'api' } do
    resources "users"
  end


  scope "", constraints: lambda { |r| r.subdomain.present? &&
    r.subdomain != 'www' } do

      match "", to: "users#show" 
      resource "user"
      resources :posts, only: [:create, :index]
      resources :users
      resources :texts
      resources :images
      resources :links
    end

    devise_for :users
    authenticated :user do
      root :to => 'dashboard#show'
    end
    
    devise_scope :user do
      get 'sign_in', :to => 'devise/sessions#new', :as => 'sign_in'
    end
    

    match '/sign_up' => 'users#new', as: 'sign_up'
    root :to => 'pages#index'
  end
