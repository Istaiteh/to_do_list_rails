class User < ApplicationRecord
    
    has_secure_password
    has_many :todos
    validates :username, uniqueness: true, presence: true, length: { in: 6..20 }
end
