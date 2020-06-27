Rails.application.routes.draw do

  namespace :users do
    get 'cuisines/show'
  end

  # 管理者側
  namespace :managers do
    resources :cookedstates, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :cuisines

    resources :foodcategories, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :foodstuffs, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :ingredients, except: [:show] do
      member do
        get 'restore'
      end
    end

    resources :procedures

    resources :rawmaterials do
      member do
        get 'restore'
      end
    end
  end


  # ユーザー側
  # UNKNOWN: urlはusersを含めない、アプリ構成ではmanagersとusersをフォルダ分けしたい
  namespace :users do
    resources :cuisines, only: [:show]
  end
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



  # for sign_in by Devise
  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

  get 'home/toppage'
  get 'home/index'
  root to: 'home#index'
end
