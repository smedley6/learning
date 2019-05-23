Rails.application.routes.draw do
  resources :questions, only: %i[create new show] do
    resources :answers, only: :create
  end
end
