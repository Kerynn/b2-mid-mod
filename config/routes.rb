Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :departments, only: [:index]
  # get "/departments", to: "departments#index"

  resources :employees, only: [:show]
  # get "/employees/:id", to: "employees#show"
end
