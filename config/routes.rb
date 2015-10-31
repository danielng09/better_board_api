Rails.application.routes.draw do
  get '/auth/google/callback', to: 'sessions#create'

  namespace :api, defaults: { format: :json } do
    resources :job_postings, only: [:show, :index]
  end

  root "static_pages#root"
end
