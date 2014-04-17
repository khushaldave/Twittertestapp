TwitterExample::Application.routes.draw do
  get "twittertweets/search"
  get "userfeed/create"
  post "tweets/search"
  get "tweets/search"
  post "tweets/searh"
  get "tweets/searh"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
 
  resources :tweets, only: [:new, :create]
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show, :index]
 
  root to: "home#index"
end
