Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'file_uploads#index'
  resources :file_uploads, only: [:create, :index]
  get 'file_uploads/:tag_search_query/:page', to: 'file_uploads#index', constraints: { page: /\d/ }

end
