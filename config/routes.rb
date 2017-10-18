Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index', as: :index


  get '/signup', to: 'user#signup', as: :signup
  post '/signup', to: 'user#psignup', as: :psignup
  get '/login', to: 'user#login', as: :login
  post '/login', to: 'user#plogin', as: :plogin
  get '/logout', to: 'user#logout', as: :logout

  get '/new-friend', to: 'friend#list', as: :newfriend
  get '/friend', to: 'friend#added', as: :addedfriend
  post '/new-friend/:id', to: 'friend#add', as: :addfriend
  post '/del-friend/:id', to: 'friend#destroy', as: :delfriend

  get '/sent', to: 'mail#sent', as: :sent
  get '/received', to: 'mail#received', as: :received
  get '/new', to: 'mail#new', as: :new
  get '/read/', to: 'mail#read', as: :read
end
