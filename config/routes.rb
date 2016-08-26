Rails.application.routes.draw do

  get 'payments/create'

  get 'payments/update'

  get 'payments/index'

  resources :students do
    resources :memberships, only: [:index]
    resources :payments, only: [:create, :update, :index]
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
