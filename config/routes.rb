FeedEngine::Application.routes.draw do
  devise_for :users

  resources "text_posts"
  resource "dashboard"
  root :to => "dashboards#show"
end
