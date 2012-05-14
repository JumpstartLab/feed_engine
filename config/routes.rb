FeedEngine::Application.routes.draw do
  root :to => 'feed#show'
  resource :dashboard, :controller => 'dashboard'

  resources :text_items
  resources :link_items
  resources :image_items

  namespace :api do
    namespace :v1 do
      namespace :feeds do
        resources :users, :only => [:show] do
          resources :stream_items, :only => [:index, :show, :create]
        end
      end
    end
  end
  devise_for :users

  #constraints :subdomain => "api" do
    #resources :text_items
  #end

  match '', to: 'feed#show', constraints: {subdomain: /.+/}


  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  root :to => 'dashboard#show'
end
