FeedEngine::Application.routes.draw do

  match "home/index" => redirect("/")

  match 'users/auth/:provider' => 'authentications#new'
  match 'users/auth/:provider/callback' => 'authentications#create'

  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  resources :authentications
  resource :dashboard, :controller => 'dashboard'

  resources :text_items
  resources :link_items
  resources :image_items
  resources :external_accounts
  resources :stream_items, :only => [:create]
  get 'external_accounts_skip' => 'external_accounts#skip_link', :as => :external_accounts_skip
  devise_for :users, :controllers => { :registrations => "users/registrations" }


  namespace :api do
  end
  devise_for :users


  constraints :subdomain => "api" do
    match "feeds/:display_name/items" => "api/stream_items#create", :as => "new_api_item", :via => :post
    match "feeds/:display_name" => "api/feeds#show", :as => "api_feed", :via => :get
    match "feeds/:display_name/items/:id" => "api/stream_items#show", :as => "api_item"
    match "feeds/:display_name/items/:id/refeeds" => "api/refeeds#create", :as => "api_refeed_item", :via => :post

    scope :module => 'api' do
      resources :feeds, :only => [:show]
      resources :stream_items, :only => [:show, :create]
    end
  end

  # if there's a subdomain, send them to feed#show, otherwise treat root as dashboard
  match '', to: 'feed#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  
  
  root :to => 'dashboard#show'
end
