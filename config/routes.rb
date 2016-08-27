Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  resources :students do
    resources :memberships, only: [:index]
    resources :payments, only: [:create, :update, :index]
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'students#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
