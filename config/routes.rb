Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  devise_for :users
  resources :users, :hosts, :activities, :locations
  resources :events do 
    resources :schedule_blocks do
      member do
        get 'confirm_delete'
      end
    end
    member do
      get 'confirm_delete'
    end
  end

end