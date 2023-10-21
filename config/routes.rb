Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :users
  get '/users', to: 'users#index'
  get '/users/:user_id', to: 'users#show'
  get '/users/:user_id/posts', to: 'posts#index'
  get '/users/:user_id/posts/new', to: 'posts#new'
  get '/users/:user_id/posts/:post_id', to: 'posts#show'
  get '/posts/:post_id/comments/new', to: 'comments#new'

  post '/users/:user_id/posts/create', to: 'posts#create'
  post '/users/:user_id/posts/:post_id/like_comment', to: 'likes#create'
  post '/users/:user_id/posts/:post_id/create_comment', to: 'comments#create'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
