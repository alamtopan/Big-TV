BigTv::Application.routes.draw do
  devise_for :users, :customers

  resources :users do
  	resources :profiles
    get :sign_out
  end

  namespace :manage do
    resources :unit_items,  path: 'channels'
    resources :group_items, path: 'channel_categories'
    resources :memberships
    resources :blogs
    resources :orders,      path: 'subcriptions'
    resources :categories
    resources :users
    resources :customers
  end
  
  resources :customers,   only: [:new, :create]
  resources :carts,       except: [:show] do
    collection do
      post '/subcribe', to: 'carts#subcribe'
    end
  end

  get   '/lokasi',   to: 'publics#lokasi',      as: 'lokasi'
  get   '/cara_berlangganan',   to: 'publics#cara_berlangganan',      as: 'cara_berlangganan'
  get   '/support',   to: 'publics#support',      as: 'support'

  get   '/show_blog/:id',   to: 'publics#show_blog',      as: 'show_blog'
  get   '/extra',   to: 'carts#extra',      as: 'extra'
  get   '/premium', to: 'carts#premium',    as: 'premium'
  get   '/preview', to: 'carts#preview',    as: 'preview'
  get   '/rental',  to: 'carts#rental_box', as: 'rental'
  
  get   '/update_package',  to: 'carts#update_package', as: 'update_package'
  
  get   '/thanks',  to: 'publics#thanks',  as: 'thanks'
  
  get   "/manage",  to: "manage/home#dashboard", as: "manage_root"

  get   '/dashboard',  to: 'home#dashboard', as: 'dashboard'
  get   '/form',       to: 'home#form',      as: 'form'
  get   '/list',       to: 'home#list',      as: 'list'
  # get   '/home',       to: 'home#home',  as: 'home'
  
  root to: 'publics#show'

  # SAMPLE DECODER
   get   '/decoder',  to: 'publics#decoder',as: 'decoder'

  # # payment gateway
  match '/gatepay/notify',   to: "gatepay#notify", via: [:get, :post]
  match '/gatepay/redirect', to: "gatepay#redirect", via: [:get, :post]
end
