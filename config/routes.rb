FeedEngine::Application.routes.draw do
  get "static_pages/show"

  devise_for :users

  scope "", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    match "", to: "users#show"
  end

  resources "users", as: :user
  resource "dashboard"
  resources "text_posts"
  resources "image_posts"
  resources "link_posts"
  root :to => "static_pages#show"

  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  root :to => "dashboards#show"
end
