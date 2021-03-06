Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  post '/', to: 'api#base'
  post '/upload', to: 'welcome#upload'
  post '/csv_select', to: 'welcome#csv_select'
  post '/connect', to: 'db_connector#connect'
end
