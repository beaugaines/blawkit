Bloccit::Application.routes.draw do

 

  get "posts/index"

  get "posts/show"

  get "posts/new"

  get "posts/edit"

  get "welcome/about"
  
  devise_for :users

  resource :dashboard, only: [:show]

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
