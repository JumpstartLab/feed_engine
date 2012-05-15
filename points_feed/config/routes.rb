PointsFeed::Application.routes.draw do
  resources :authentications

  match "home/index" => redirect("/")
  match "auth/:provider/callback" => "authentications#create"

  get "/socialmedia", :to => "twitters#show"

  devise_for :users, :controllers => { :registrations => :registrations } do
    get "signin", :to => "devise/sessions#new", as: :new_user_session
    get "signup", :to => "devise/registrations#new", as: :new_user_registration
  end

  resource :twitter do
    get "/skip", :to => "twitters#skip_step"
  end

  resource :dashboard

  namespace :api do
    resources :feeds do
      collection do
        get "/:id/items.json" => 'feeds#items'
        post "/:id/items/:item_id/refeeds.json" => 'feeds#refeed'
      end
    end

    resources :posts
  end

  scope '/', constraints: lambda { |r| r.subdomain == 'api' } do
    namespace :api, :path => '/' do
      resources :feeds do
        collection do
          get "/:id/items.json" => 'feeds#items'
          post "/:id/items/:item_id/refeeds.json" => 'feeds#refeed'
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
