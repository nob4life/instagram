Rails.application.routes.draw do
  #get '/users', to: 'users#index'
  devise_for :users
  root to: 'posts#index'
  resources :likes, only: [:create, :destroy]
  resources :users
  resources :posts do
   resources :comments
  end
end
