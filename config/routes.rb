Rails.application.routes.draw do
  devise_for :users
  root 'lots#index'
  resources :lots
  resources :tags
  resources :users
end
