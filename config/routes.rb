require 'sidekiq/web'

Rails.application.routes.draw do
  resources :dashboard, only: [:index]
  resources :grid_views, only: [:index]
  resources :organisation_memberships, only: [:destroy, :index, :create, :update]
  resources :organisations, only: [:new, :edit, :update, :create]
  resources :projects, only: [:new, :edit, :update, :create, :index]

  namespace :working_project do
    resources :tasks, only: [:index, :update]
  end

  resources :notification_all_as_reads, only: [:create]
  resources :notifications, only: [:index]

  resources :task_boards, only: [:update, :create, :index, :show]
  resources :task_lists, only: [:create] do
    patch "move"
  end

  resources :tasks, only: [:update, :create] do
    patch "move"
  end

  resources :issues, only: [:update, :create, :index] do
    resources :comments, module: :issues
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { invitations: "users/invitations" }
  root to: 'home#index'
  resources :users, only: [:index] do
    resources :grid_views, only: [:index, :create, :edit, :destroy]
    resources :grid_view_columns, only: [:create, :destroy] do
      member do
        patch :move
      end
    end
  end

  namespace :users do
    resources :current_projects, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
