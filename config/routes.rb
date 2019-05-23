Rails.application.routes.draw do
  resources :questions, only: :create do
    resources :answers, only: :create
  end
end
