Rails.application.routes.draw do
  resources :publications
  root "publications#index"
end
