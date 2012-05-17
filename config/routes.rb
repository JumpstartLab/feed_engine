FeedEngine::Application.routes.draw do
  get "items/show"

  match "/auth/:provider/callback" => "subscriptions#create"

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
    namespace :api, :path => '/' do
      namespace :v1 do
        scope "/feeds/:display_name" do
          match "/" => "items#index"
          match "/profile" => "users#show"
          resources :items
        end
      end
    end
  end

  constraints(Subdomain) do
    match "/" => "users#show"
  end

  root to: "home#index"
end
