Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:index, :show, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
