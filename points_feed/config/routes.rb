PointsFeed::Application.routes.draw do
  resources :authentications

  match "home/index" => redirect("/")
  match "auth/:provider/callback" => "authentications#create"

  devise_for :users do
    get "signin", :to => "devise/sessions#new"
    get "signup", :to => "devise/registrations#new"
  end

  resource :dashboard
  
  namespace :api do
    resources :feeds do
      get '/items/' => 'feeds#items'
    end
  end

  scope '', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
  end

  root :to => "home#index"

  resources :posts
end
