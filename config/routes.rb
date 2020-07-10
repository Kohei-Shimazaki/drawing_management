Rails.application.routes.draw do
  resources :companies
  resources :teams
  devise_for :users, controllers: {
    invitations: 'users/invitations'
  }
  resources :users, only: [:show]
  resources :drawings
  resources :revisions
  resources :tasks do
    resources :evidences, only: %i(create edit update destroy)
    resources :references, only: %i(create edit update destroy)
  end
  resources :questions do
    resources :comments, only: %i(create edit update destroy)
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'drawings#index'
end
