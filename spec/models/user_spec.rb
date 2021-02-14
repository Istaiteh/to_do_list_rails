require "rspec/expectations"
require 'rails_helper'



RSpec.describe User, type: :model do
  before(:example) do
    Todo.delete_all
    User.delete_all
  end
  after(:example) do
    Todo.delete_all
    User.delete_all
  end
  it "has 0 user at the start" do
    expect(User.count).to eq(0) 
  end
  it "has 1 user after #create" do
    User.create(:username => "test123456", :password => "123456789")
    expect(User.count).to eq(1) 
  end
  it "does not accept less than 6 characters username" do 
    User.create(:username => "test1", :password =>"123456789")
    expect(User.count).to eq(0)
  end
  it "does not accept more than 20 characters username" do 
    User.create(:username => "test123456789123456789123542", :password =>"123456789")
    expect(User.count).to eq(0)
  end
  it "does not store the plan password" do
    pass = "123456789"
    user = User.new(:username=> "test123", :password => pass)
    id = user.id 
    user.save
    id = user.id 
    saved_user = User.find(id)
    expect(saved_user.password).to_not eq(pass)
  end

  describe 'associations' do
    it { should have_many(:todos) }
  end
end
