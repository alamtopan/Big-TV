BigTv::Application.routes.draw do
  devise_for :users

  resources :users do
  	resources :profiles
  end
  resources :unit_items,  path: 'channels'
  resources :group_items, path: 'channel_categories'
  resources :memberships
  resources :categories
  resources :carts, except: [:show]


  root :to => 'publics#home'

  get   '/extra/:membership_id',      to: 'publics#extra',    as: 'extra'
  
  get   '/dashboard',  to: 'home#dashboard',as: 'dashboard'
  get   '/home',       to: 'publics#home',  as: 'home'
  get   '/order',       to: 'publics#order',  as: 'order'
  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',       to: 'home#list', as: 'list'

end
