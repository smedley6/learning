Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  resources :questions, only: %i[create new show index destroy] do
    resources :answers, only: %i[create destroy]
  end
end
