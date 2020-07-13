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
    resources :evidences, only: %i(create destroy)
    resources :references, only: %i(create destroy)
  end
  resources :questions do
    resources :comments, only: %i(create edit update destroy)
  end
  resources :likes, only: %i(create destroy)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'drawings#index'
end
