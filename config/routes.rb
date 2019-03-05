Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :index]
        post '/login', to: 'auth#create'
        get '/user', to: 'auth#show'
      resources :memes
      resources :games
      resources :rounds
    end
  end


end
