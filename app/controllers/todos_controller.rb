class TodosController < ApplicationController
  before_action :authorized


  # GET /todos
  def index
    @todos = Todo.where(:user_id => @user.id)

    render json: {todos: @todos, status: :success}
  end

  # GET /todos/1
  def show
    @todo = Todo.find(params[:id])
    if @user.id != @todo.user_id
      render json: {error: "It is not your item"}, :status => :unauthorized
    else 
      render json: {data: @todo, status: :success}
    end
  end

  # POST /todos
  def create
    
    @todo = Todo.new(:description => description, :user_id => @user.id, :completed => completed)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    @todo = Todo.find(params[:id])
    if @user.id != @todo.user_id
      render json: {error: "It is not your list"}, :status => :unauthorized
    else
      if @todo.update(:description => description, :completed => completed)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end

    end


  end

  # DELETE /todos/1
  def destroy
    @todo = Todo.find(params[:id])
    if @user.id != @todo.user_id
      render json: {error: "It is not your list"}, status: :unauthorized
    else 
      @todo.destroy
      render json: {message: "deleted successfully"}, status: :ok
    end
  end

  private


    # Only allow a list of trusted parameters through.
    def description
      request.headers['description']
    end
    def completed
      request.headers['completed']
    end
end
