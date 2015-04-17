Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
<<<<<<< HEAD
  resources :users, :events, :hosts, :activities, :locations
end
=======
  resources :users, :hosts, :activities, :locations, :events
end
>>>>>>> Start of Event form...pushing now to start new branch for Friday night code-athon
