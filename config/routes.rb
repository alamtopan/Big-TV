BigTv::Application.routes.draw do
  devise_for :users

  resources :unit_items
  resources :group_items

  root :to => 'home#dashboard'

end
