Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :job_postings, only: [:show, :index]
  end
end
