require 'rails_helper'

RSpec.describe "Comments", type: :request do
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
      stub_request(:get, "https://jsonplaceholder.typicode.com/posts/1/comments").to_return(body: $fake_comments)
      it "renders a successful response" do
          get "/posts/1/comments", headers: @valid_headers, as: :json
          expect(response).to be_successful
        end
      end
    
      describe "GET /show" do
      it "renders a successful response" do
        stub_request(:get, "https://jsonplaceholder.typicode.com/posts/1/comments/1").to_return(body: $fake_comment)
          get "/posts/1/comments/1", headers: @valid_headers, as: :json
          expect(response).to be_successful
        end
      it "renders a unsuccessful response to non found comment" do
        stub_request(:get, "https://jsonplaceholder.typicode.com/posts/1/comments").to_return(body: $fake_comments)
          get "/posts/1/comments/1000", headers: @valid_headers, as: :json
          expect(response).to have_http_status(404)
        end
       it "renders a unsuccessful response to non found post" do
        stub_request(:get, "https://jsonplaceholder.typicode.com/posts/1000/comments").to_return(body: {}.to_json)
            get "/posts/1000/comments/1000", headers: @valid_headers, as: :json
            expect(response).to have_http_status(404)
          end
      end
    
end
