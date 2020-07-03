Rails.application.routes.draw do
  resources :comments, only: %i(new create edit update)
  resources :drawings
  resources :revisions
  resources :tasks
  resources :questions
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
