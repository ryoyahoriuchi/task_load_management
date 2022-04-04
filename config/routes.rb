Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks do
    collection do
      post :suggestion
      patch :suggestion
    end
    member do
      patch :suggestion
    end
  end
end
