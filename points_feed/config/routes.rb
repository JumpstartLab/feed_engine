PointsFeed::Application.routes.draw do
  get "home/index"

  devise_for :users do
    get "signin", :to => "devise/sessions#new"
    get "signup", :to => "devise/registrations#new"
  end

  root :to => "home#index"
end
