Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
    resources :labels
  end
  resources :users
  resources :sessions
  resources :tasks
  get '/', to: 'tasks#index'
end