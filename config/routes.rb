Rails.application.routes.draw do
  
  root 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :students
      resources :courses
      resources :grades
    end
  end

  get '*path', to: 'pages#index', via: :all
end
