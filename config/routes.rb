Bloccit::Application.routes.draw do

  devise_for :users

  get "welcome/about"
  get "welcome/index"

  root to: 'welcome#index'
 
end
