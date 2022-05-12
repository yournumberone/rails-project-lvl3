# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'sign_in', to: 'auth#new'
    delete 'sign_out', to: 'auth#destroy'

    resources :bulletins

    namespace :admin do
      resources :bulletins
      resources :categories
      resources :users
    end
  end
end
