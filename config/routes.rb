Rails.application.routes.draw do
  root to: 'recipes#index'

  devise_for :users

  resources :recipe_types, only: %i[ show new create ]
  resources :cuisines, only: %i[ show new create ]
  resources :recipe_lists, only: %i[ index new create show ]
  resources :recipes, only: %i[ show new create edit update my ] do
    get 'search', on: :collection
    get 'my', on: :collection
    get 'pending', on: :collection
    post 'add_to_list', on: :member
    post 'activate', on: :member
    post 'reject', on: :member
    delete 'remove_from_list', on: :member
  end

  namespace 'api' do
    namespace 'v1' do
      resources :recipes, only: %i[ show ]
      resources :recipe_types, only: %i[ create]
    end
  end
end
