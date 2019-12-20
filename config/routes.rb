Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/faq'
  root 'home#index'
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show]
end
