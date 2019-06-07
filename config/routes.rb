Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root 'static_pages#home'

  resources :users do
  	#resources :questions, shallow: true
  	resources :questions, except: [:index] 
  end

  resources :questions do
  	resources :answers
  end

  get 'help', to: 'static_pages#help'
  get '/questions', to: 'questions#index'
  get '/questions/:question_id/upvote/:id', to: 'question_votes#ques_upvote', :as => :ques_upvote
  get '/questions/:question_id/downvote/:id', to: 'question_votes#ques_downvote', :as => :ques_downvote
  get '/answers/:answer_id/upvote/:id', to: 'question_votes#ans_upvote', :as => :ans_upvote
  get '/answers/:answer_id/downvote/:id', to: 'question_votes#ans_downvote', :as => :ans_downvote
end
