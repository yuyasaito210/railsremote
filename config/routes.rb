Rails.application.routes.draw do
  resources :candidates
  default_url_options :host => "3b72b360.ngrok.io"
  root 'jobs#index'
  resources :jobs do
  	collection do
      get :autocomplete
    end
  end
  resources :admin_jobs, only: [:index, :new, :create, :update, :destroy, :edit, :show] do
  	put :publish
  end

  resource :sitemap, only: [:show], defaults: { format: :xml }
 end
