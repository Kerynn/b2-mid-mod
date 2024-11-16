Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :departments, only: [:index]
  # get "/departments", to: "departments#index"
end
