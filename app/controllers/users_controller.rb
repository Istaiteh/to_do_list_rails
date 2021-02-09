class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
    def create


        @user = User.create(:username => usr, :password => pass)

        if @user.valid?
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      def login
        @user = User.find_by(username: usr )
    
        if @user && @user.authenticate(pass)
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      def auto_login
        render json: @user
      end
    
      private
      def pass
        request.headers[:password] 
      end 
      def usr
        request.headers[:username]
      end 

end
