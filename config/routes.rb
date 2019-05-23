Rails.application.routes.draw do
  resources :questions, only: :create
end
