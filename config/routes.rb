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
  get 'external_accounts_skip' => 'external_accounts#skip_link', :as => :external_accounts_skip
  devise_for :users, :controllers => { :registrations => "users/registrations" }


  namespace :api do
  end
  devise_for :users


  constraints :subdomain => "api" do
    match "/v1/feeds/:display_name/items" => "api/v1/feeds/stream_items#create", :as => "new_api_item", :via => :post
    match "/v1/feeds/:display_name" => "api/v1/feeds/stream_items#index", :as => "api_feed", :via => :get
    match "/v1/feeds/:display_name/stream_items/:id" => "api/v1/feeds/stream_items#show", :as => "api_item"

    scope :module => 'api' do
      namespace :v1 do
        namespace :feeds do
          resources :users, :only => [:show] do
            resources :stream_items, :only => [:index, :show, :create]
          end
        end
      end
    end
  end

  # if there's a subdomain, send them to feed#show, otherwise treat root as dashboard
  match '', to: 'feed#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root :to => 'dashboard#show'
end
