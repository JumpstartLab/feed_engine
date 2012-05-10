FeedEngine::Application.routes.draw do
  devise_for :users

  resources "text_posts"
  resource "dashboard"

  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  root :to => "dashboards#show"
end
