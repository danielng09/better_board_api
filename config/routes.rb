Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :job_postings, only: [:show, :index]
  end

  root to: 'job_postings#index'
end
