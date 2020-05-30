Rails.application.routes.draw do
  namespace :managers do
    # get 'foodcategories/index'
    resources :foodcategories, except: [:show] do
      member do
        get 'restore'
      end
    end
  end

  # letter_opener_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  devise_for :managers, controllers: {
    sessions:      'managers/sessions',
    passwords:     'managers/passwords',
    registrations: 'managers/registrations'
  }

  get 'home/index'

  root to: 'home#index'
end
