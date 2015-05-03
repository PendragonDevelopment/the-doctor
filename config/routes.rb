Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  devise_for :users
  resources :users, :events, :hosts, :activities, :locations
end