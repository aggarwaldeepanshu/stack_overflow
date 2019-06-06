Rails.application.routes.draw do
  #get 'question_votes/new'
  #get 'question_vote/new'
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
  get '/questions/:question_id/upvote/:id', to: 'question_votes#upvote', :as => :upvote
  get '/questions/:question_id/downvote/:id', to: 'question_votes#downvote', :as => :downvote

end
