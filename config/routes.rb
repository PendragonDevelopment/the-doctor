Rails.application.routes.draw do
  get 'my_calendar/show'

  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  devise_for :users
  resources :users, :events, :hosts, :activities, :locations
end