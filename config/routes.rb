BigTv::Application.routes.draw do
  devise_for :users

  resources :unit_items
  resources :group_items
  resources :memberships

  root :to => 'home#dashboard'

  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',       to: 'home#list', as: 'list'

end
