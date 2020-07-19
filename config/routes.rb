Rails.application.routes.draw do
  resources :companies
  resources :customers
  resources :projects
  resources :categories
  resources :category_assigns, only: %i(create destroy)
  resources :teams
  resources :team_assigns, only: %i(create destroy)
  devise_for :users, controllers: {
    invitations: 'users/invitations'
  }
  resources :users, only: [:show]
  resources :drawings
  resources :revisions
  resources :tasks do
    resources :evidences, only: %i(create destroy)
    resources :references, only: %i(create destroy)
    collection do
      post :revision_assign
    end
    member do
      post :revision_assign_delete
    end
  end
  resources :questions do
    resources :comments, only: %i(create edit update destroy)
  end
  resources :likes, only: %i(create destroy)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root to: 'drawings#index'
end
