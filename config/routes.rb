Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :user
      resources :memes
    end
  end


end
