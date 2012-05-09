FeedEngine::Application.routes.draw do
  resources "text_posts"
  resource "dashboard"
  resources "image_posts"
end
