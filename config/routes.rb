Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :departments, except: [:index, :show]
    resources :users, except: [:show]
  end

  concern :stats do
    get 'stats', on: :member
  end

  resources :departments, only: [:index, :show], concerns: :stats
  resources :users, only: [:show], concerns: :stats
  resources :worktimes, only: [:index, :show, :create, :edit, :update, :destroy], path: 'worktime'
  resources :records do
    get :vacation, :sickness, :day_off, on: :new
    get :pending,     on: :collection
    get :requested,   on: :collection
    get :bookkeeping, on: :collection
    get :boss_approve,    on: :member
    get :boss_disapprove, on: :member
    get :bookkeeper_approve, on: :member
    resources :comments, except: [:index, :show]
  end

  root 'root#index'
end