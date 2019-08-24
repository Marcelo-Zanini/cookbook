Rails.application.routes.draw do
  root to: 'recipes#index'

  devise_for :users

  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipe_lists, only: %i[index new create show]
  resources :recipes, only: %i[show new create edit update my] do
    post 'add_to_list', on: :member
    delete 'remove_from_list', on: :member
  end
  get 'my_recipes', to: 'recipes#my'
  get 'search', to: 'recipes#search'
end
