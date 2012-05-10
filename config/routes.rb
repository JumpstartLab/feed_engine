FeedEngine::Application.routes.draw do
  devise_for :users

  resource "dashboard"

  resources "text_posts"
  resources "image_posts"
  resources "link_posts"

  root :to => "dashboards#show"
end
