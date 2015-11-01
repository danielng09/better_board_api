Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  namespace :api, defaults: { format: :json } do
    resources :job_postings, only: [:show, :index]
  end

  root "home#show"
end
