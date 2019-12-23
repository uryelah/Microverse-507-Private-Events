Rails.application.routes.draw do
  get 'events/create'
  get 'events/new'
  get 'events/show'
  get 'events/index'
  resources  :users, only: [:new, :create, :show]
  resources  :users, only: [:new, :create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
