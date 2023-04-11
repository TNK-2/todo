class Api::V1::TodosController < ApplicationController
  before_action :authorize_request
  before_action :set_todo, only: [:show, :update, :destroy]
  
  # GET /api/v1/todos
  def index
    @todos = @current_user.todos

    render json: @todos
  end

  # GET /api/v1/todos/1
  def show
    render json: @todo
  end

  # POST /api/v1/todos
  def create
    @todo = @current_user.todos.new(todo_params)

    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/todos/1
  def destroy
    @todo.destroy
  end

  private

    def todo_params
      params.permit(:title, :description, :completed)
    end

    def set_todo
      @todo = @current_user.todos.find(params[:id])
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

end
