Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :drawings
  resources :revisions
  resources :tasks
  resources :questions do
    resources :comments, only: %i(create edit update destroy)
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'drawings#index'
end
