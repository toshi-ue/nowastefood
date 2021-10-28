# frozen_string_literal: true

Rails.application.routes.draw do
  # 管理者側
  devise_for :managers, controllers: {
    sessions: 'managers/sessions',
    passwords: 'managers/passwords',
    registrations: 'managers/registrations'
  }

  devise_scope :manager do
    post 'login_as_guest_manager', to: 'managers/sessions#login_as_guest_manager'
  end
  namespace :managers do
    resources :cookedstates, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :cuisines
    resources :foodcategories, except: [:show]
    resources :foodstuffs, except: [:index, :show] do
      member do
        put :sort
      end
      collection do
        get 'search_foodcategory'
        get 'search_rawmaterial'
        get 'search_unit'
      end
    end

    resources :ingredients, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :procedures, except: [:index] do
      member do
        put :sort
      end
    end

    resources :rawmaterials do
      member do
        get 'restore'
      end
    end
    get 'dashboard', to: 'tops#dashboard'
  end

  # ユーザー側
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'login_as_guest_user', to: 'users/sessions#login_as_guest_user'
  end
  resources :cookinghistorys, only: [:index]
  resources :cuisines, only: [:show] do
    delete :remove_favorite
    delete :remove_menu
    delete :remove_from_todays_menus, action: :remove_from_todays_menus, controller: 'cookinghistorys'
    post :add_favorite
    post :add_menu
    post :add_to_todays_menu, action: :add_to_todays_menu, controller: 'cookinghistorys'
    collection do
      get :search
    end
  end
  resources :contacts, only: [:show, :new, :create]
  resources :favorites, only: [:index, :create, :destroy]
  post '/add_todaysmenu/:cuisine_id', to: 'favorites#add_todaysmenu_from_favorite', as: 'add_todaysmenu_from_favorite'
  delete '/remove_todaysmenu/:cuisine_id', to: 'favorites#remove_todaysmenu_from_favorite', as: 'remove_todaysmenu_from_favorite'
  resources :keywords, only: [:index]
  resources :managecuisines do
    patch :toggle_status
  end
  resources :manageownfoodstuffs
  resources :manageownprocedures
  resources :userrawmaterials, only: [:index, :new, :create]
  resources :stocks, only: [:index, :new, :create, :destroy] do
    collection do
      get 'auto_today_create'
      get 'search_rawmaterial'
      get 'search_unit_and_expiry_period'
    end
  end
  resources :todaysmenus, only: [:index, :update, :destroy] do
    collection do
      post 'cooked_done'
    end
  end

  # TODO: 原材料から探せるようにする
  # get 'rawmaterials/search'
  get 'search/foodcategory_search', to: 'search#foodcategory_search'
  get 'search/rawmaterial_search', to: 'search#rawmaterial_search'
  get 'search/unit_search', to: 'search#unit_search'
  get '/about', to: 'tops#about'
  # get 'tops/index'
  get 'user/profile', to: 'users#show'
  put 'update_profile', to: 'users#update'

  root to: 'tops#index'

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
