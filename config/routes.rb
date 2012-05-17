FeedEngine::Application.routes.draw do
  get "static_pages/show"

  devise_for :users

  # User subdomains
  scope "", constraints: Subdomains.user_feeds do
    match "", to: "users#show"
  end

  # Api subdomain
  scope module: "api", as: "api", constraints: Subdomains.api do
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

  resources "users", as: :user
  match "/auth/twitter/callback" => "users#twitter"
  resource "dashboard"
  resources "text_posts"
  resources "image_posts"
  resources "link_posts"
  resources "feed_items"
  resources "authentications", only: [:show]
  resources "points", only: [:update]
  resources "refeeds", only: [:create]
  root :to => "static_pages#show"

  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  root :to => "dashboards#show"
end
