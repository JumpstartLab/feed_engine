FeedEngine::Application.routes.draw do
  match "/auth/:provider/callback" => "subscriptions#create"
  get "items/show"

  resources :subscriptions
  resources :messages
  resources :images
  resources :users
  resources :sessions
  resources :links
  resource  :dashboard,
            :controller => "dashboard",
            :only => "show"

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  constraints :subdomain => 'api', :format => :json do
    match '/feeds/:display_name(.:format)' => 'api/users#show', as: "feed"
    match '/feeds/:display_name/items/:id' => 'api/items#show', as: "feed_item"
  end

  constraints(Subdomain) do
    match "/" => "users#show"
  end

  root to: "home#index"
end
