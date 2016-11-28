Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'users/sign_in'
  resources :tasks do
    resources :follow_ups
  end

  root to: 'tasks#index'
end