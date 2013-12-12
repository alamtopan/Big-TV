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


  get   '/extra/:membership_id', to: 'carts#extra',    as: 'extra'
  get   '/preview',              to: 'carts#preview',  as: 'preview'
  
  get   '/dashboard',  to: 'home#dashboard',as: 'dashboard'
  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',       to: 'home#list', as: 'list'
  # get   '/home',       to: 'home#home',  as: 'home'
  
  root to: 'publics#show'
end
