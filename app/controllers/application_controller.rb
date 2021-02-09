class ApplicationController < ActionController::API

    before_action :authorized
    def encode_token(payload)
        JWT.encode(payload, secret)
      end
      def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
      end

      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          JWT.decode(token, secret, true, algorithm: 'HS256')
        end
      end
      def logged_in_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
          if @user
            return true
          else
            return 
                false   
          end
        end
      end

    def logged_in?
        logged_in_user
    end
    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
    private 
      def secret
      "a784795793b3c28cf08efa367c1abdd1365a8312080a5ad7a1bb91e189c0918e4c35b08b8df02d18264dbaccff619fa73ef2f3eacfe88b4fc49309d4b3b911f1"
      end
end
