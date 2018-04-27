Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  '/', to: 'consent#index'
  post '/', to: 'consent#index'
  get  '/experiment', to: 'main#experiment'
  post '/experiment', to: 'main#experiment'
  get  '/statement', to: 'main#statement'
  post '/answer/:id', to: 'main#answer'
  post '/test_read/:id', to: 'main#test_read'
  get  '/thank_you', to: 'main#thank_you'
  get  '/instructions', to: 'main#instructions'
  get  '/next', to: 'main#next'
  get  '/next_fix_back_button', to: 'main#next_fix_back_button'
  root to: 'consent#index'
  match "/500", :to => "main#thank_you", :via => :all
  # match "*path" => redirect("/"), via: [:get]
end
