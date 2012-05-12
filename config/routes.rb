FeedEngine::Application.routes.draw do
  get "static_pages/show"

  devise_for :users

  scope "", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    match "", to: "users#show"
    resource "user"
  end

  resource "dashboard"
  resources "text_posts"
  resources "image_posts"
  resources "link_posts"
  root :to => "static_pages#show"
end
