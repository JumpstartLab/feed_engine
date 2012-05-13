FeedEngine::Application.routes.draw do
  get "static_pages/show"

  devise_for :users

  resource "dashboard"

  resources "text_posts"
  resources "image_posts"
  resources "link_posts"
  root :to => "static_pages#show"
end
