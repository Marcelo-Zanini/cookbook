Rails.application.routes.draw do
  root to: 'recipes#index'

  resources :recipes, only: %i[show new create]
end
