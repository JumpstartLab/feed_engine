PointsFeed::Application.routes.draw do
  resources :authentications

  match "home/index" => redirect("/")
  match "auth/:provider/callback" => "authentications#create"

  devise_for :users do
    get "signin", :to => "devise/sessions#new"
    get "signup", :to => "devise/registrations#new"
  end

  resource :twitter do
    get "/skip", :to => "twitters#skip_step"
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

  scope '/', constraints: lambda { |r| r.subdomain == 'api' } do
    namespace :api, :path => '/' do
      resources :feeds do
        collection do
          get "/:id/items.json" => 'feeds#items'
        end
      end

      resources :posts
    end
  end

  scope '/', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    get '/' => 'home#profile'
  end

  root :to => "home#index"

  resources :posts
end
