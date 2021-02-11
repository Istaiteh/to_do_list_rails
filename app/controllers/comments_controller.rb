class CommentsController < ApplicationController
    def index
        url = "https://jsonplaceholder.typicode.com/posts/#{params["post_id"]}/comments"
        body = RestClient.get(url)
        
        render json: {comments: JSON.parse(body)}, :status => :ok 
   end

   def show
       url = "https://jsonplaceholder.typicode.com/posts/#{params["post_id"]}/comments"
       body = JSON.parse(RestClient.get(url))
       id = params["id"].to_i
       body.each do |comment| 
            if comment["id"].eql? id
                render json: {comment: comment}, :status => :ok
                return
            end 
       end
       render json: {}, :status => 404
   end
end
