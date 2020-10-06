Rails.application.routes.draw do
  # 管理者側
  namespace :managers do
    resources :cookedstates, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :cuisines
    resources :foodcategories, except: [:show]
    resources :foodstuffs, except: [:show] do
      member do
        put :sort
      end
      collection do
        get 'search_rawmaterial'
      end
    end

    resources :ingredients, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :procedures do
      member do
        put :sort
      end
    end

    resources :rawmaterials do
      member do
        get 'restore'
      end
    end
  end

  # ユーザー側
  # UNKNOWN: urlはusersを含めない、アプリ構成ではmanagersとusersをフォルダ分けしたい
  namespace :users do
    # resources :cuisines, only: [:show]
    resources :stocks do
      collection do
        get 'search_rawmaterial'
      end
    end
  end
  resources :cuisines, only: [:show] do
    delete :remove_favorite
    delete :remove_menu
    post :add_favorite
    post :add_menu
    post :favorite, action: :add_menu_on_the_day, controller: 'favorites'

  end
  resources :favorites, only: [:index, :create, :destroy]
  get 'genres/search'
  # TODO: 原材料から探せるようにする
  # get 'rawmaterials/search'
  get 'tag_search', action: :search, controller: 'tags'
  resources :todaysmenus, only: [:index, :update, :destroy]

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  devise_for :managers, controllers: {
    sessions: 'managers/sessions',
    passwords: 'managers/passwords',
    registrations: 'managers/registrations'
  }

  # authenticated do
  #   root to: "secret#index", as: :authenticated_root
  # end
  get 'home/index'
  get 'tops/about'
  get 'tops/index'
  get 'tops/login_which'
  if Rails.env.development?
    root to: 'home#index'
  else
    root to: 'tops#about'
  end
end
