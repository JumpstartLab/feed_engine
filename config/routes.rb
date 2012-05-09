FeedEngine::Application.routes.draw do
  resources "text_posts"
  resource "dashboard"
end
