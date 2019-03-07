Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :index]
        post '/login', to: 'auth#create'
        get '/user', to: 'auth#show'
        post '/start', to: 'rounds#start'
        post '/answer', to: 'rounds#answer'
        post '/increment', to: 'rounds#increment'
      resources :memes
      resources :games
      resources :rounds
    end
  end


end
