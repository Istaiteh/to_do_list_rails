require 'rails_helper'

RSpec.describe "Users", type: :request do
    before(:example) do
        Todo.delete_all
        User.delete_all
      end
      after(:example) do
        Todo.delete_all
        User.delete_all
      end
    describe "Post creater" do
        it "it create a new user" do 
        post "/users/create", :headers=> {:username => "othman",:password =>"123456789"} 
        expect(User.count).to eq(1)
        end

        it "respond to short username" do 
            post "/users/create", :headers=> {:username => "ot", :password =>"123456789"} 
            expect(response.body).to match(/Invalid username or password/)
        end
        it "does not create dublicate users" do 
            post "/users/create", :headers=> {:username => "othman",:password =>"123456789"} 
            post "/users/create", :headers=> {:username => "othman",:password =>"1234589"} 
            expect(User.count).to eq(1)
        end
    end

    describe "Post login" do 
        it "it success on correct log in" do
            User.create(:username => "othman", :password => "123456789")
            post "/login", :headers=> {:username => "othman",:password =>"123456789"} 
            expect(JSON.parse(response.body)["status"]).to match(/success/)
        end 
        it "it does not success on correct log in" do
            User.create(:username => "othman", :password => "123456789")
            post "/login", :headers=> {:username => "othman",:password =>"12"} 
            expect(JSON.parse(response.body)["status"]).to match(/unauthorized/)
        end 
    end 

    describe "Auto login" do
        it "returns the user information if logged in" do
            user = User.create(:username => "othman", :password => "123456789")
            post "/login", :headers=> {:username => "othman",:password =>"123456789"} 
            token = "Bearer #{JSON.parse(response.body)["token"]}"
            get "/auto_login", as: :json, headers: {:Authorization => token}
            puts(response.body)
            expect(JSON.parse(response.body)["id"]).to eq(user.id) 

            
        end 
    end

end
