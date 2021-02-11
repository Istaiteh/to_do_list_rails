class PostsController < ApplicationController
    def index
         url = 'https://jsonplaceholder.typicode.com/posts'
         body = RestClient.get(url)
         render json: {posts: JSON.parse(body)}, :status => :ok 
    end

    def show
        url = "https://jsonplaceholder.typicode.com/posts/#{params["id"]}"
        begin 
            body = RestClient.get(url) 
        rescue RestClient::NotFound
            render json: {}, :status => 404
        else 
            render json: {post: JSON.parse(body)}, :status => :ok
        end 
    end
end
