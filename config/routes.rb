Rails.application.routes.draw do

  match 'registration/start', via: [:get, :post, :put]
  match 'registration/register', via: [:get, :post]
  match 'registration/wei_register', via: [:get, :post]
  get 'registration/questions'
  post 'registration/pay'
  match 'registration/card', via: [:get, :post]
  get 'registration/details'

  ActiveAdmin.routes(self)

  resources :students do
    member do
      patch :card
    end
    resources :memberships, only: [:index]
    resources :payments, only: [:create, :update, :index]
  end

  resources :payments, only: [:index]

  scope 'wei' do
    resources :wei_registrations do
      member do
        post 'pay', as: :pay
      end
      collection do
        get 'waiting'
        get 'deposit'
        get 'registered'
        get 'unregistered'
        get 'to_refund'
        get 'parental'
      end
    end
    resources :wei_bungalows
    resources :wei_buses
  end

  get 'email/:key' => 'email#show', as: :view_email
  get 'email' => 'email#show' unless Rails.env.production?

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'students#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
