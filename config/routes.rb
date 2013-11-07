Bloccit::Application.routes.draw do

  get 'about', to: 'welcome#about'

  resources :posts do
    resources :comments, shallow: true
  end

  resources :topics do
    resources :posts, except: [:index]
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
