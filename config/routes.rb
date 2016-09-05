Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  resources :students do
    member do
      patch :card
    end
    resources :memberships, only: [:index]
    resources :payments, only: [:create, :update, :index]
  end

  scope 'wei' do
    resources :wei_registrations do
      member do
        post 'pay', as: :pay
      end
      collection do
        get 'waiting'
        get 'deposit'
      end
    end
    resources :wei_bungalows
    resources :wei_buses
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'students#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
