Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources  :invites, only: [:create, :update, :destroy]
  resources  :users, only: [:new, :create, :show, :index]
  resources  :events, only: [:new, :create, :show, :index]
end
