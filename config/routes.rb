Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users, :hosts, :activities, :locations
  resources :events do 
    member do
      get 'delete'
      get 'new_schedule_block'
      post 'new_schedule_block'
    end
  end
end