Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users, :events, :hosts, :activities, :locations
end