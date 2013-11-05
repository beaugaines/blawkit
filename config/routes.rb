Bloccit::Application.routes.draw do

  get "comments/create"

  resources :posts do
    resources :comments, shallow: true
  end

  get 'about', to: 'welcome#about'
  
  devise_for :users

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
