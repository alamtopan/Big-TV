BigTv::Application.routes.draw do
  devise_for :users

  resources :users do
  	resources :profiles
  end
  resources :unit_items,  path: 'channels'
  resources :group_items, path: 'channel_categories'
  resources :memberships

  root :to => 'home#dashboard'

  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',       to: 'home#list', as: 'list'

end
