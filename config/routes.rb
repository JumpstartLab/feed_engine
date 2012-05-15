FeedEngine::Application.routes.draw do
 

  root :to => 'feed#show'

  match 'users/auth/:provider' => 'authentications#new'
  match 'users/auth/:provider/callback' => 'authentications#create'
  
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

  match '', to: 'feed#show', constraints: {subdomain: /.+/}


  devise_scope :user do
    get "signup" => "devise/registrations#new", :as => :new_user
    get "login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy"
  end
end
