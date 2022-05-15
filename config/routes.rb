# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'web/bulletins#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'sign_in', to: 'auth#new'
    delete 'sign_out', to: 'auth#destroy'

    resources :bulletins do
      member do
        patch 'archive'
        patch 'to_moderate'
      end
    end

    namespace :admin do
      resources :bulletins, only: :index do
        member do
          patch 'reject'
          patch 'publish'
          patch 'archive'
        end
      end
      resources :categories
      resources :users
    end

    get 'profile', to: 'profile#index'
  end
end
