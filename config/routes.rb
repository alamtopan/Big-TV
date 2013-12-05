BigTv::Application.routes.draw do
  devise_for :users

  root :to => 'home#dashboard'

  get   '/form',       to: 'home#form',  as: 'form'
  get   '/list',              to: 'home#list', as: 'list'

end
