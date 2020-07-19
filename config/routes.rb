Rails.application.routes.draw do
  root to: 'users#show'
  resources :companies
  resources :customers
  resources :projects
  resources :categories
  resources :category_assigns, only: %i(create destroy)
  resources :teams
  resources :team_assigns, only: %i(create destroy)
  devise_for :users, controllers: {
    invitations: 'users/invitations',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'new_company', to: 'users/registrations#new_company'
    post 'create_company', to: 'users/registrations#create_company'
  end
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
end
