FeedEngine::Application.routes.draw do
  resources "posts"
  resource "dashboard"
  resources "image_posts"
end
