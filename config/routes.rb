Rails.application.routes.draw do
  default_url_options :host => "3b72b360.ngrok.io"
  root 'jobs#index'
  resources :jobs, only: [:index, :show, :new, :create]
  resources :admin_jobs, only: [:index, :new, :create, :update, :destroy, :edit, :show] do
  	put :publish
  end

  resource :sitemap, only: [:show], defaults: { format: :xml }
 end
