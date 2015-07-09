class Api::TodoListsController < Api::ApiController

  def index
    Rails.logger.info "current user: #{current_user.inspect}"
    render json: TodoList.all
  end

  def show
    list = current_user.todo_lists.find(params[:id])
    render json: list.as_json(include:[:todo_items])
    #including the items in the response
  end

  def create
    list = current_user.todo_lists.new(list_params)
    if list.save
      render status: 200, json: {
        message: "Succesfully created todo-list",
        todo_list: list
      }.to_json
    else
      render status: 500, json: {
        errors: list.errors
      }.to_json
    end
  end

  def update
    list = current_user.todo_lists.find(params[:id])
    if list.update_attributes(list_params)
      render status: 200, json: { 
        message: "updated the post!",
        todo_list: list
      }.to_json
    else
      render status: 422, json: {
        message: "Could not be updated",
        todo_list: list
      }.to_json
    end
  end

  def destroy
    list = current_user.todo_lists.find(params[:id])
    list.destroy
    render status: 200, json: {
      message: "Succesfully deleted to-do list"
    }.to_json
  end

  private

  def list_params
    params.require(:todo_list).permit(:title)
  end
end