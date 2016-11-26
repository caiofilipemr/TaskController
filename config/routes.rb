Rails.application.routes.draw do
  devise_for :users
  get 'users/sign_in'
  resources :tasks

  root to: 'tasks#index'
end