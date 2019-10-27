Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions: 'users/sessions', confirmations: 'users/confirmations' }

  get 'companies/filter', path: 'companies/filter'

  resources :groups

  resources :companies do
    member do
      get 'dashboard'
      get 'subscription_packages'
      get 'update_subscription_package'
      get 'display_surveys'
    end
  end

  resources :company_settings
  resources :user_settings
  resources :members do
    member do
      get 'calculate_surveys'
    end
  end

  resources :surveys do
    member do
      get 'survey_charts'
    end
    collection do
      get 'add_question'
      get 'add_option'
      get 'delete_option'
      get 'delete_question'
    end
    resources :user_responses
  end

  resources :home do
    collection do
      get 'index'
      get 'filter_category'
      get 'sign_in'
      post 'sign_in_redirect'
    end
  end

  get "*path", to: 'application#page_not_found'

  get :dashboard, to: 'companies#dashboard'
end