Rails.application.routes.draw do
  resources :comments, only: %i(new create edit update)
  resources :drawings
  resources :revisions
  resources :tasks
  resources :questions
end
