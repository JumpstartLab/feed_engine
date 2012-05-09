FeedEngine::Application.routes.draw do
  resource :dashboard, :controller => 'dashboard'

  resources :text_items
end
