Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "homes#top"
  resources :lists do 
    resources :words, only: [:new, :create, :edit, :update, :destroy]
  end
  patch "word/update_status" => "words#update_status", as: "update_status"
end
