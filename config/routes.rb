Rails.application.routes.draw do
  resources :questions, only: %i[create new show index] do
    resources :answers, only: :create
  end
end
