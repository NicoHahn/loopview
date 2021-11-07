Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'sessions#welcome'
  resources :projects
  resources :templates
  resources :sessions
  resources :users
end
