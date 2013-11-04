Bloccit::Application.routes.draw do

 


  resources :posts

  get 'about', to: 'welcome#about'
  
  devise_for :users

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
