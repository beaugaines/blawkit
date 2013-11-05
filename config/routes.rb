Bloccit::Application.routes.draw do

  get 'about', to: 'welcome#about'

  resources :posts do
    resources :comments, shallow: true
  end

  resources :topics
  
  devise_for :users

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
