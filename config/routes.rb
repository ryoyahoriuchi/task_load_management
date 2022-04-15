Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "tasks#index"
  resources :tasks do
    resources :memos
    collection do
      post :suggestion
      patch :suggestion
    end
    member do
      patch :suggestion
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
