Rails.application.routes.draw do
  # 管理者側
  namespace :managers do
    resources :ingredients, except: [:show] do
      member do
        get 'restore'
      end
    end
    resources :foodcategories, except: [:show] do
      member do
        get 'restore'
      end
    end
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

  get 'home/index'

  root to: 'home#index'
end
