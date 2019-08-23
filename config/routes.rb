Rails.application.routes.draw do
  root to: 'recipes#index'

  devise_for :users

  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipes, only: %i[show new create edit update my ]
  get 'my_recipes', to: 'recipes#my'
  get 'search', to: 'recipes#search'
end
