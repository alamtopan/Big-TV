BigTv::Application.routes.draw do
  devise_for :users

  resources :users do
  	resources :profiles
  end
  resources :unit_items,  path: 'channels'
  resources :group_items, path: 'channel_categories'
  resources :memberships
  resources :categories

  root :to => 'publics#home'

  get   '/dashboard',       to: 'home#dashboard',  as: 'dashboard'
  get   '/home',       to: 'publics#home',  as: 'home'
  get   '/order',       to: 'publics#order',  as: 'order'
  get   '/extra',       to: 'publics#extra',  as: 'extra'
  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',       to: 'home#list', as: 'list'

end
