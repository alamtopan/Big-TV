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
    resources :orders,      path: 'subcriptions' do
      collection do
        match :extra, via: [:get, :post]
        get   :new_customer
        post  :create_customer
        get   :rental_box
        get   :preview
        get   :premium
        post  :subcribe
      end
    end
    resources :categories
    resources :users
    resources :customers
    resources :referrals
    resources :page_contents
    resources :referral_categories
    resources :regionals
    resources :offices
    resources :category_offices
    resources :services
    resources :jobs
    resources :job_applicants do
      get :download, on: :member
    end
  end
  
  resources :customers,   only: [:new, :create]
  resources :carts,       except: [:show] do
    collection do
      post '/subcribe', to: 'carts#subcribe'
    end
  end
  
  post   '/create_support',   to: 'publics#create_support',      as: 'create_support'
  post   '/create_job',   to: 'publics#create_job',      as: 'create_job'

  get   '/carriers',   to: 'publics#carriers',           as: 'carriers'
  get   '/show_carrier/:id',  to: 'publics#show_carrier',         as: 'show_carrier'
  get   '/lokasi',    to: 'publics#lokasi',            as: 'lokasi'
  get   '/reg',       to: 'publics#cara_berlangganan', as: 'cara_berlangganan'
  get   '/support',   to: 'publics#support',           as: 'support'

  get   '/news/:id',  to: 'publics#show_blog',         as: 'show_blog'
  get   '/extra',     to: 'carts#extra',               as: 'extra'
  get   '/premium',   to: 'carts#premium',             as: 'premium'
  get   '/preview',   to: 'carts#preview',             as: 'preview'
  get   '/rental',    to: 'carts#rental_box',          as: 'rental'

  
  get   '/dashboard', to: 'home#dashboard',            as: 'dashboard'
  get   '/form',      to: 'home#form',                 as: 'form'
  get   '/list',      to: 'home#list',                 as: 'list'

  get   '/thanks',    to: 'publics#thanks',            as: 'thanks'
  
  get   "/manage",    to: "manage/home#dashboard",     as: "manage_root"

  # SAMPLE DECODER
   get  '/decoder',  to: 'publics#decoder',as: 'decoder'

  # # payment gateway
  match '/gatepay/notify',       to: "gatepay#notify",               via: [:get, :post]
  match '/gatepay/redirect',     to: "gatepay#redirect",             via: [:get, :post]
  
  get   '/payment-instruction',  to: 'publics#payment_instruction',  as: 'payment_instruction'
  get   '/update_package',       to: 'carts#update_package',         as: 'update_package'


  # get   '/home',       to: 'home#home',  as: 'home'

  root to: 'publics#show'

end
