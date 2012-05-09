PointsFeed::Application.routes.draw do
  get "home/index"

  devise_for :users do
    get "signin", :to => "devise/sessions#new"
    get "signup", :to => "devise/registrations#new"
  end

  resource :dashboard

  scope '', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
  end

  root :to => "home#index"

  resources :posts
end
