class TodosController < ApplicationController
  before_action :authorized
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.where(:user_id => @user.id)

    render json: @todos, status: :success
  end

  # GET /todos/1
  def show
    if @user.id != @todo.user_id
      render json: {error: "It is not your list", status: authorized}
    else 
      render json: @todo, status: :success
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
    if @user.id != @todo.user_id
      render json: {error: "It is not your list"}
    else
      if @todo.update(:description => description, :completed => completed, status: :success)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end

    end


  end

  # DELETE /todos/1
  def destroy
    if @user.id != @todo.user_id
      render json: {error: "It is not your list", status: :unauthorized}
    else 
      @todo.destroy
      render json: {message: "deleted successfully", status: :success}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def description
      request.headers['descreption']
    end
    def completed
      request.headers['completed']
    end
end
