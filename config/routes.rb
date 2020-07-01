Rails.application.routes.draw do
  resources :drawings
  resources :revisions
  resources :tasks
  resources :questions
end
