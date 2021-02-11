require 'rails_helper'

RSpec.describe "Posts", type: :request do
    before(:example) do 
        cont = ApplicationController.new
          Todo.delete_all
          User.delete_all
        Rails.application.load_seed
        @id = User.first.id
        @todo_id = User.find(@id).todos.first.id 
        @token = cont.encode_token({user_id: @id})
        @valid_headers = {:Authorization => "Bearer #{@token}"}
      end
    describe "GET /index" do
        it "renders a successful response" do
          get "/posts", headers: @valid_headers, as: :json
          expect(response).to be_successful
        end
        it "checks the output based on a double" 
      end
    
      describe "GET /show" do
        it "renders a successful response" do
          get "/posts/1", headers: @valid_headers, as: :json
          expect(response).to be_successful
        end
        it "renders a unsuccessful response" do
          get "/posts/1000", headers: @valid_headers, as: :json
          expect(response).to have_http_status(404)
        end

      end
    

end
