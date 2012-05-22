FeedEngine::Application.routes.draw do
  get "items/show"

  match "/auth/:provider/callback" => "subscriptions#create"

  resources :subscriptions
  resource  :messages
  resource  :images
  resource  :links
  resources :users
  resources :items
  resources :sessions
  resources :password_resets
  resource  :dashboard,
            :controller => "dashboard",
            :only => "show"


  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  put "refeed/:id", to: "items#refeed", as: "refeed"

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
