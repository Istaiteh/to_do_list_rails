require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe "Post creater" do
        it "it create a new user" do 
        user = User.new(({:username => "othman", :password =>"123456789", :id => 1}))
        allow(User).to receive(:create).with({:username => "othman",:password =>"123456789"} ).and_return(user)
        allow(user).to receive(:valid?).and_return(true)
        allow(User).to receive(:count).and_return(1)
        post "/users/create", :headers=> {:username => "othman",:password =>"123456789"} 
        expect(User.count).to eq(1)
        end

        it "respond to short username" do 
            allow(User).to receive(:create).with({:username => "ot", :password =>"123456789"} ).and_return(User.new({:username => "ot", :password =>"123456789"} ))
            post "/users/create", :headers=> {:username => "ot", :password =>"123456789"} 
            expect(response.body).to match(/Invalid username or password/)
        end
    end

    describe "Post login" do 
        it "it success on correct log in" do
            user = User.new(({:username => "othman", :password =>"123456789", :id => 1}))
            allow(User).to receive(:find_by).with({:username => "othman"}).and_return(user)
            allow(user).to receive(:authenticate).with("123456789").and_return(true)
            post "/login", :headers=> {:username => "othman",:password =>"123456789"} 
            expect(response).to be_successful
        end 
        it "it does not success on wrong log in" do
            user = User.new(({:username => "othman", :password =>"123456789", :id => 1}))
            allow(User).to receive(:find_by).with({:username => "othman"}).and_return(user)
            allow(user).to receive(:authenticate).with("12").and_return(false)
            post "/login", :headers=> {:username => "othman",:password =>"12"} 
            expect(response).to have_http_status(:unauthorized)
        end 
    end 

    describe "Auto login" do
        it "returns the user information if logged in" do
            cont = ApplicationController.new
            user = User.new(:username => "othman", :password => "123456789", :id => 1)
            allow(User).to receive(:find_by).with({:id => 1}).and_return(user)
            token = cont.encode_token({user_id: user.id})
            headers = {:Authorization => "Bearer #{token}"}
            get "/auto_login", as: :json, headers: headers
            expect(JSON.parse(response.body)["id"]).to eq(user.id) 
        end 
    end

end
