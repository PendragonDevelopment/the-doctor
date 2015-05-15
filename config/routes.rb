Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  devise_for :users
  resources :hosts, :activities, :locations
  resources :users do
    member do 
      get 'my_appointments'
    end
  end
  resources :events do 
    member do
      get 'confirm_delete'
      get 'new_schedule_block'
      post 'create_schedule_block'
      get 'show_schedule_block'
      get 'edit_schedule_block'
      post 'update_schedule_block'
      get 'block_schedule_block'
      post 'create_appointment'
    end
    collection do
      get 'index_schedule_block'
    end
  end

end