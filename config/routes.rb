Bloccit::Application.routes.draw do

  get 'about', to: 'welcome#about'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show]

  resources :topics do
    resources :posts, except: [:index] do
      resources :favorites, only: [:create, :destroy]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote
      match '/down-vote', to: 'votes#down_vote', as: :down_vote
    end
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
