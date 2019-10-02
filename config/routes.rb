Rails.application.routes.draw do

  root to: 'tasklists#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]

  resources :tasklists
end
