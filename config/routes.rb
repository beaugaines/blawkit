Bloccit::Application.routes.draw do

  get "welcome/about"
  
  devise_for :users

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
 
end
