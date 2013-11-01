Bloccit::Application.routes.draw do

  get "welcome/about"
  get "welcome/index"

  root to: 'welcome#index'
 
end
