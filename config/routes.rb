Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  
  resources :users, only: [:index, :show, :create] do
    member do
      get :likes
      get :likeds
    end
  end
  resources :shop_join, only: [:index]
  resources :items, only: [:index, :show, :new, :create, :destroy]
  resources :trades, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
