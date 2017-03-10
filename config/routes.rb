Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  post '/', to: 'application#base'
  post '/upload', to: 'welcome#upload'
  post '/csv_select', to: 'welcome#csv_select'
  post '/connect', to: 'db_connector#connect'
end
