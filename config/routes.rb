Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  root to: "prototypes#index"
  
  resources :prototypes, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  resources :prototypes do
    resources :comments, only: :create
  end

  resources :comments, only: :show

  resources :users, only: :show

  

end
