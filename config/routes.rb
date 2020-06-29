Rails.application.routes.draw do
  resources :drawings
  resources :revisions, only: %i(new create)
  resources :tasks
end
