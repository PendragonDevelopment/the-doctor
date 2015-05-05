Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  devise_for :users
  resources :users, :hosts, :activities, :locations
  resources :events do 
    member do
      get 'confirm_delete'
      get 'new_schedule_block'
      post 'create_schedule_block'
      get 'show_schedule_block'
      get 'edit_schedule_block'
      post 'update_schedule_block'
      get 'cancel_schedule_block'
    end
    collection do
      get 'index_schedule_block'
    end
  end

end