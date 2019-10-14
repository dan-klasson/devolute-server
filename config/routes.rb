Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :registrations, only: [:create], path: 'registration'
  resources :authentications , only: [:create], path: 'authentication'
  resources :images, only: [:index, :create]
end
