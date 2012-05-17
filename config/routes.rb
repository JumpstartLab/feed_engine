FeedEngine::Application.routes.draw do
  get "items/show"

  match "/auth/:provider/callback" => "subscriptions#create"

  resources :subscriptions
  resources :messages
  resources :images
  resources :users
  resources :sessions
  resources :links
  resources :password_resets
  resource  :dashboard,
            :controller => "dashboard",
            :only => "show"


  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  constraints :subdomain => 'api', :format => :json do
    match '/feeds/:display_name(.:format)' => 'api/users#show', as: "feed", :defaults => { :format => 'json' }
    match '/feeds/:display_name/items/:id' => 'api/items#show', as: "feed_item", :defaults => { :format => 'json' }
    match '/feeds/:display_name/items' => 'api/items#index', as: "feed_item_index", :defaults => { :format => 'json' }

  end

  constraints(Subdomain) do
    match "/" => "users#show"
  end

  root to: "home#index"
end
