PointsFeed::Application.routes.draw do
  resources :authentications

  match "home/index" => redirect("/")
  match "auth/:provider/callback" => "authentications#create"

  devise_for :users do
    get "signin", :to => "devise/sessions#new", as: :new_user_session
    get "signup", :to => "devise/registrations#new", as: :new_user_registration
  end

  resource :dashboard
  
  namespace :api do
    resources :feeds do
      collection do
        get "/:id/items.json" => 'feeds#items'
      end
    end

    resources :posts
  end

  scope '/', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    get '/' => 'home#profile'
  end

  root :to => "home#index"

  resources :posts
end
