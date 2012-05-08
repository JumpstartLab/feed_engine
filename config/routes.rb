Hungrlr::Application.routes.draw do

  resources :growls

  root :to => 'growls#index'
end
