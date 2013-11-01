Bloccit::Application.routes.draw do

  get "welcome/about"

  root to: 'welcome#index'
 
end
