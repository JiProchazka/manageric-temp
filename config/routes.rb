Rails.application.routes.draw do

  get     'login',                              to: 'auth#new'
  post    'login',                              to: 'auth#create',  as: 'users'
  delete  'logout',                             to: 'auth#destroy', as: 'users_destroy'

  resources :projects, only: [:create, :show] do
    resources :project_items, path: 'items', only: [:create, :destroy, :show] do
      resources :comments, only: [:create, :destroy]
    end
    post   'project-items/change-state',        to: 'project_items#change_state'
  end

  get   'browse/:project_id/:id',               to: 'project_items#show', as: 'browse'
  get   'dashboard',                            to: 'home#dashboard'

  post  'api/project_items/save-description',   to: 'api/project_items#save_description'
  post  'api/project_items/save-title',         to: 'api/project_items#save_title'
  get   'api/users/search/:term',               to: 'api/users#search'
  get   'api/users/get-for-project/:id',        to: 'api/users#get_for_project'
  post  'api/users/add-to-project',             to: 'api/users#add_to_project'
  post  'api/users/remove-from-project',        to: 'api/users#remove_from_project'
  post  'api/comments/save-content',            to: 'api/comments#save_content'
  root  'home#index'
end
