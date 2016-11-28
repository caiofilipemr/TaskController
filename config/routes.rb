Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd', :controllers => { registrations: 'registrations' }
  get 'users/sign_in'
  resources :tasks do
    resources :follow_ups
  end
  resources :users

  root to: 'tasks#index'
end