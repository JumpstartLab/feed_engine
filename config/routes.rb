FeedEngine::Application.routes.draw do

  match 'users/auth/:provider' => 'authentications#new'
  match 'users/auth/:provider/callback' => 'authentications#create'

  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end

  resources :authentications, :only => [:new, :create, :destroy]
  resource :dashboard, :controller => 'dashboard'

  resource :signup_link_twitter, :only => :show, :controller => :signup_link_twitter
  resource :signup_link_github, :only => :show, :controller => :signup_link_github
  get 'signup_twitter_skip' => 'signup_link_twitter#skip', :as => :signup_twitter_skip
  get 'signup_github_skip' => 'signup_link_github#skip', :as => :signup_github_skip


  resources :points, :only => [:create]
  resources :text_items, :image_items, :link_items, :only => [:create]
  resources :external_accounts
  resources :subscriptions, :only => [:create, :destroy]
  resources :stream_items, :only => [:create]
  resource :feed
  resource :river, :only => [:show]
  devise_for :users, :controllers => { :registrations => "users/registrations" }

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

  # if there's a subdomain, send them to feed#show, treat dashboard as root
  scope :api do
    match "feeds/:display_name/items" => "api/stream_items#create", :as => "new_api_item", :via => :post
    match "feeds/:display_name" => "api/feeds#show", :as => "api_feed", :via => :get
    match "feeds/:display_name/stream_items/:id" => "api/stream_items#show", :as => "api_item"
    match "feeds/:display_name/stream_items/:id/refeeds" => "api/refeeds#create", :as => "api_refeed_item", :via => :post

    scope :module => 'api' do
      resources :feeds, :only => [:show]
      resources :stream_items, :only => [:show, :create]
    end
  end

  # if there's a subdomain, send them to feed#show, otherwise treat root as dashboard
  match '', to: 'feed#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  # match 'user_root' => redirect('/dashboard')
  root :to => 'river#show'
end
