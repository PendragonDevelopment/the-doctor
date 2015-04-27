Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users, :hosts, :activities, :locations
  resources :events do 
    get :delete, :on => :member
  end
end
