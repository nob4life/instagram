Rails.application.routes.draw do
  get '/add_photo', to: 'users#add_photo'
  devise_for :users
  root to: 'posts#index'
  resources :likes, only: [:create, :destroy]
  resources :users do
    member do 
      get :following, :followers
    end
  end
  resources :posts do
   resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
