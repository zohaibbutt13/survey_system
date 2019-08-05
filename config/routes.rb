Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, :controllers => { registrations: 'users/registrations', sessions: 'users/sessions' }

  get 'companies/filter', path: 'companies/filter'

  resources :groups

  resources :companies do
    member do
      get 'dashboard'
      get 'display_surveys'
    end
  end

  resources :company_settings
  resources :user_settings
  resources :members

  resources :surveys do
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
      get 'packages'
      get 'main_charts'
    end
    member do
      get 'survey_charts'
    end
  end

  resources :activity do
    collection do
      get 'index'
    end
  end

  get :dashboard, to: 'companies#dashboard'
  # devise_for :users, :controllers => { registrations: 'registrations' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end