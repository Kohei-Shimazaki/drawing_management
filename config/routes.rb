Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :comments, only: %i(new create edit update)
  resources :drawings
  resources :revisions
  resources :tasks
  resources :questions
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'drawings#index'
end
