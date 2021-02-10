require 'rails_helper'

RSpec.describe Todo, type: :model do
  before(:example) do
    Todo.delete_all
  end
  after(:example) do
    Todo.delete_all
    User.delete_all
  end
  it "has 0 user at the start" do
    expect(Todo.count).to eq(0) 
  end
  it "has 1 user after #create" do
    user = User.create(:username => "test123456", :password => "123456789")
    Todo.create(:user_id=>user.id, :description => "item", :completed => false)
    expect(Todo.count).to eq(1) 
  end
  
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

end
