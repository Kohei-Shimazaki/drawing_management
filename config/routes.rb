Rails.application.routes.draw do
  resources :tasks, only: %i(new create)
end
