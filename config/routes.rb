Rails.application.routes.draw do
  #get 'answers/new'
  #get 'questions/new'
  #get 'users/new'

  #get 'static_pages/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root 'static_pages#home'
  # get '/help', to: 'static_pages#help'
  # get '/signup', to: 'users#new'
  # post '/signup', to: 'users#create'

  resources :users do
  	#resources :questions, shallow: true
  	resources :questions, except: [:index] 
  end

  resources :questions do
  	resources :answers
  end

  get 'help', to: 'static_pages#help'

  get '/questions', to: 'questions#index'
end
