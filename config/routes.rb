Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "lists#index"
  resources :lists, only: [:show, :create, :destroy, :update]
  resources :words, only: [:create, :update]
end
