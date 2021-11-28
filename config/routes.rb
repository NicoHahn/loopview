Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'sessions#welcome'
  resources :projects
  resources :issue_templates do
    collection do
      post :add_attribute
    end
  end
  resources :sessions
  resources :users
  resources :concrete_issue_templates do
    collection do
      post :send_to_jira
    end
  end


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'

end
