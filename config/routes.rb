FeedEngine::Application.routes.draw do
  get "static_pages/show"

  devise_for :users, :controllers => {:registrations => "registrations"}


  # User subdomains
  scope "", constraints: Subdomains.user_feeds do
    match "", to: "users#show"
  end

  # Api subdomain
  scope module: "api", as: "api", constraints: Subdomains.api do
    resources "users", only: [:index]
    resources "relationships", only: [:index]
    resources "feeds" do
      collection do
        scope ":user_display_name" do
          resources "items" do
            resources "refeeds"
          end
        end
      end
    end
  end

  resources "feeds" do
    collection do
      scope ":user_display_name" do
        resources "items"
      end
    end
  end

  resources "users", as: :user do
    member do
      get :following, :followers, :refeeds
    end
  end


  match "/auth/twitter/callback" => "authentications#twitter"
  match "/auth/github/callback" => "authentications#github"
  match "/auth/instagram/callback" => "authentications#instagram"
  match "/user_signup_steps/finish" => "user_signup_steps#finish"

  resource "dashboard"
  resources "text_posts"
  resources "image_posts"
  resources "link_posts"
  resources "feed_items"
  resources "authentications", only: [:show, :destroy]
  resources "points", only: [:create]
  resources "refeeds", only: [:create]
  resources "user_signup_steps"
  resources "relationships", only: [:create, :destroy, :index]

  root :to => "static_pages#show"

  devise_scope :user do
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
    get "signup" => "registrations#new", :as => :new_user
  end

  root :to => "dashboards#show"
end
