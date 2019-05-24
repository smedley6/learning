Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  resources :questions, only: %i[create new show index] do
    resources :answers, only: :create
  end
end
