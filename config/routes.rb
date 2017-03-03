Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  post '/', to: 'application#base'
  post '/upload', to: 'welcome#upload'
  post '/csv_select', to: 'welcome#csv_select'
end
