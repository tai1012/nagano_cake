Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "customers/homes#top"
  get "/about" => "customers/homes#about"
  resources :homes, only:[:top, :about]

  scope module: "customers" do
    resources :items, only:[:index, :show]
    resource :customers, only:[:edit, :update]
    get "customers/my_page" => "/customers/customers#show"
    get "customers/unsubscribe" => "/customers/customers#unsubscribe"
    patch "customers/withdraw" => "/customers/customers#withdraw"
    delete "cart_items/destroy_all" => "/customers/cart_items#destroy_all"
    resources :cart_items, only:[:index, :update, :destroy, :create]
    post "orders/confirm" => "/customers/orders#confirm"
    get "orders/complete" => "/customers/orders#complete"
    resources :orders, only:[:new, :index, :show, :create]
    # post "orders" => "/customers/orders#create"
    resources :addresses, only:[:index, :create, :edit, :update, :destroy]
  end

  get "/admins" => "admins/homes#top" #注文履歴全体の
  namespace :admins do
    resources :items, only:[:new, :index, :create, :edit, :show, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end
  
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  # post "/customers/sign_up" => "customers/registrations#create"
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords'
  }
end
