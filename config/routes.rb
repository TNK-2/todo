Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :todos
      get  '/check_token', to: 'sessions#check_token'
      get  '/user', to: 'users#show'
      post '/signup', to: 'users#create'
      post '/login', to: 'sessions#create'
    end
  end
  
end
