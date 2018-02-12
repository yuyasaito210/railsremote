Rails.application.routes.draw do
  root 'jobs#index'
  resources :jobs
  resources :admin_jobs, only: [:index, :update, :destroy]
  resource :sitemap, only: [:show], defaults: { format: :xml }
  end
