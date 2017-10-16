Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index', as: :index
  get '/signup', to: 'user#signup', as: :signup
  get '/login', to: 'user#login', as: :login
  get '/sent', to: 'mail#sent', as: :sent
  get '/received', to: 'mail#received', as: :received
  get '/new', to: 'mail#new', as: :new
  get '/read/', to: 'mail#read', as: :read
end
