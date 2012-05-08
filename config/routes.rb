FeedEngine::Application.routes.draw do
  root to: 'home#index'

  resource :dashboard, :controller => "dashboard", :only => "show"

  resources :posts
  resources :users, :only => :show

end
