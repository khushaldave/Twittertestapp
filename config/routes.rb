TwitterExample::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get "twittertweets/search"
    end
  end
  #get "twittertweets/search"
  get "twittertweets/search"
  post "twittertweets/search"
  get "twittertweets/index"
  get "userfeed/create"
  post "tweets/search"
  get "tweets/search"
  post "tweets/searh"
  get "tweets/searh"
   get "tweets/index"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
 
  resources :tweets, only: [:index, :create]
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show, :index]
 
  root to: "home#index"
end
