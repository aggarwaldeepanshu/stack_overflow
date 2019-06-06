require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new, params: {
      	user_id: 1
      }
      #get :new_user_question
      #get '/users/:user_id/questions/new'
      # visit new_user_question_path, params: { user_id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

end
