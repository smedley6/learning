Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions, only: %i[create new show index] do
    resources :answers, only: :create
  end
end
