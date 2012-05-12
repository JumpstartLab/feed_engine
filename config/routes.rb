Hungrlr::Application.routes.draw do
  match "/home" => "pages#home"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/auth/:provider/callback' => 'authentications#create'

  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login' => 'devise/sessions#new'
  end

  resources :growls, :images, :links, :messages, :authentications
  resource :dashboard

  namespace :api do
    namespace :v1 do
      scope ':display_name', :as => "user" do
        resources :growls
        resources :meta_data
      end
    end
  end

  constraints(Subdomain) do
    match '/' => 'growls#show'
  end

  root :to => 'pages#home'
end
