user1 = User.create(username: "othman", password: "123456789")
user2 = User.create(username: "othman2", password: "123456789")







for i in 1..20 do

    Todo.create(:description => "Item number #{i} for #{user1.username}", :user_id => user1.id , :completed => false )
end

for i in 1..20 do

    Todo.create(:description => "Item number #{i} for #{user2.username}", :user_id => user2.id , :completed => false )
end