Rails.application.routes.draw do
  resources :candidates
  default_url_options :host => "3b72b360.ngrok.io"
  root 'jobs#index'
  resources :jobs do
  	collection do
      get :autocomplete
      get :preview
      post :edit_from_json
    end
  end
  resources :admin_jobs do
    collection do
      get :autocomplete
      get :preview
      post :edit_from_json
    end
  	put :publish
  end

  resource :sitemap, only: [:show], defaults: { format: :xml }
 end
