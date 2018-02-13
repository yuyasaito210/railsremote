Rails.application.routes.draw do
  default_url_options :host => "3b72b360.ngrok.io"
  root 'jobs#index'
  resources :jobs
  resources :admin_jobs, only: [:index, :update, :destroy]
  resource :sitemap, only: [:show], defaults: { format: :xml }
 end
