# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'sessions_controller/create'

  get '/auth/:provider/callback', to: 'sessions#create'

  post '/auth/login', to: 'authentication#authenticate'
  post '/auth/signup', to 'users#create'

  # Enforce the 1:m association at the routing level by nesting
  resources :merchants do
    resources :products
  end
end
