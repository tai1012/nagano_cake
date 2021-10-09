Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "customers/homes#top"
  get "/about" => "customers/homes#about"
  resources :homes, only:[:top, :about]

  get "/admins" => "admins/homes#top"
  namespace :admins do
    resources :items, only:[:new, :index, :create, :edit, :show, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end
end
