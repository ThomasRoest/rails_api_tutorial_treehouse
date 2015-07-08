class Api::TodoListsController < ApplicationController
	def index
    render json: TodoList.all
  end
end