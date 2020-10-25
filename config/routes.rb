Rails.application.routes.draw do
  # 管理者側
  devise_for :managers, controllers: {
    sessions: 'managers/sessions',
    passwords: 'managers/passwords',
    registrations: 'managers/registrations'
  }
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
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resource :password, only: [:edit, :update]
  resources :cuisines, only: [:show] do
    delete :remove_favorite
    delete :remove_menu
    post :add_favorite
    post :add_menu
    post :favorite, action: :add_menu_on_the_day, controller: 'favorites'
  end
  resources :favorites, only: [:index, :create, :destroy]
  resources :stocks, only: [:index, :new, :create, :destroy] do
    collection do
      get 'search_rawmaterial'
      get 'unit_search'
    end
  end
  resources :todaysmenus, only: [:index, :update, :destroy]

  get 'genres/search'
  get 'home/index'
  # TODO: 原材料から探せるようにする
  # get 'rawmaterials/search'
  get 'tag_search', action: :search, controller: 'tags'
  get 'tops/about'
  get 'tops/index'
  get 'tops/login_which'
  get 'user/profile', to: 'users#show'
  get 'user/subscription', to: 'subscriptions#show'
  put 'update_profile', to: 'users#update'
  post 'register_subscription', to: 'subscriptions#create'
  delete 'cancel_subscription', to: 'subscriptions#destroy'

  if Rails.env.development?
    root to: 'home#index'
  else
    root to: 'tops#about'
  end

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
