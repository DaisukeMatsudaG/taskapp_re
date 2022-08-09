Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'users#show'
  #post 'check', to: 'users#view'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'users/new'

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'


  #taskに関してのルーティング
  resources :tasks do
    member do
      patch :update_status
    end
  end
  patch 'all_done_destroy' , to: 'tasks#all_done_destroy', as: "all_done_destroy_task"


  #post '/' ,to: 'tasks#show'
end
