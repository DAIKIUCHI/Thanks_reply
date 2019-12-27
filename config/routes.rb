Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # ログアウト
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/faq'
  resources :users, only: [:show]

  resources :tweets do
    collection do
      get 'reply'
    end
  end
end
