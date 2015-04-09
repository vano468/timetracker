Rails.application.routes.draw do
  devise_for :users

  scope :admin, module: :admin do
    resources :departments, except: [:index, :show]
    resources :users, except: [:index, :show]
  end

  concern :stats do
    get 'stats', on: :member
  end

  resources :departments, only: [:index, :show], concerns: :stats
  resources :users, only: [:show], concerns: :stats
  resources :records do
    get :pending,   on: :collection
    get :requested, on: :collection
  end

  root to: redirect('departments')
end
