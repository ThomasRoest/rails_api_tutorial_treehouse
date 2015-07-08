require 'spec_helper'

describe "Editing todo lists" do
  let(:user) { todo_list.user }
  let!(:todo_list) { create(:todo_list) }

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    todo_list = options[:todo_list]

    visit "/todo_lists"
    click_link todo_list.title
    click_link "Edit"
    
    fill_in "Title", with: options[:title]
    click_button "Save"
  end

  before do
    sign_in todo_list.user, password: "treehouse1"
  end


  it "updates a todo list successfully with correct information" do
    update_todo_list todo_list: todo_list, 
                     title: "New title"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
  end

  it "displays an error with no title" do
    update_todo_list todo_list: todo_list, title: ""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content(/can't be blank/i)
  end

  it "displays an error with too short a title" do
    update_todo_list todo_list: todo_list, title: "hi"
    expect(page).to have_content(/is too short/i)
  end

end