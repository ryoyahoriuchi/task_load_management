Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "top#index"
  resources :users, only: %i[show]
  resources :tasks do
    resources :memos
    collection do
      post :suggestion
      patch :suggestion
      get :other_achievement
    end
    member do
      patch :suggestion
      get :achievement
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
