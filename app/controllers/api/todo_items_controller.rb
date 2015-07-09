class Api::TodoItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :find_todo_list

  def index
    todo_items = @list.todo_items.all
    render json: todo_items
  end

  def show
    todo_item = @list.todo_items.find(params[:id])
    render json: todo_item
  end

  def create
    item = @list.todo_items.new(item_params)
    if item.save
      render status: 200, json: {
        message: "successfully created todo item",
        todo_list: @list,
        todo_item: item
      }.to_json
    else
      render status: 422, json: {
        message: "could not create todo item",
        errors: item.errors
      }.to_json
    end
  end

  def update
    item = @list.todo_items.find(params[:id])
    if item.update(item_params)
      render status: 200, json: {
        message: "successfully updated todo item",
        todo_list: @list,
        todo_item: item
      }.to_json
    else
      render status: 422, json: {
        message: "could not update item",
        errors: item.errors
      }.to_json
    end
  end

  def destroy
    item = @list.todo_items.find(params[:id])
    item.destroy
      render status: 200, json: {
        message: "successfully destroyed this item", 
        todo_list: @list,
        todo_item: item
      }.to_json
  end


  private

  def item_params
    params.require(:todo_item).permit(:content)
  end

  def find_todo_list
    @list = TodoList.find(params[:todo_list_id])
  end
end