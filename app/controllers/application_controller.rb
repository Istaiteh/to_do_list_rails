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
        Rails.application.credentials.dig(:secret_key_base)
      end
end
