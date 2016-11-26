require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"

configure do #this is telling Sinatra
  enable :sessions
  set :sessions_secret, 'secret'
end

before do
  session[:lists] ||= []
end

helpers do
  def display_remaining(list)
    total_tasks = list[:todos].size
    remaining_tasks = list[:todos].select{|chore| chore[:completed] == false}.size
    "#{remaining_tasks}/#{total_tasks}"
  end

  def list_complete?(list)
    list[:todos].size > 0 && list[:todos].all? {|todo| todo[:completed] }
  end

  def list_class(list)
    "complete" if list_complete?(list)
  end

  def sort_lists(lists, &block)
    complete_lists, incomplete_lists = lists.partition { |list| list_complete?(list) }

    incomplete_lists.each {|list| yield(list, lists.index(list))}
    complete_lists.each {|list| yield(list, lists.index(list))}
  end

  def sort_todos(todos, &block)
    incomplete_todos = {}
    complete_todos = {}

    todos.each_with_index do |todo, index|
      if todo[:completed]
        complete_todos[todo] = index
      else
        incomplete_todos[todo] = index
      end
    end
    incomplete_todos.each(&block)
    complete_todos.each(&block)
  end

end


# View all lists
get "/lists" do
  @lists = session[:lists]
  erb :lists, layout: :layout
end

get "/" do
  redirect "/lists"
end

# Render the new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end

# Return an error message if the name is invalid.  Return nil if name is valid.
def error_for_list_name(name)
  if !(1..100).cover? name.size
    "The list name must be between 1 and 100 characters."
  elsif session[:lists].any? {|list| list[:name] == name}
    "The list name must be unique."
  end
end

def error_for_todo(name)
  if !(1..100).cover? name.size
    "Todo must be between 1 and 100 characters."
  end
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip
  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :new_list, layout: :layout
  else
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end

# Display a single todo list contents.
get "/lists/:number" do
  @list_index = params[:number].to_i
  @list = session[:lists][@list_index]
  erb :single_list, layout: :layout
end

# Render list name edit form
get "/lists/:number/edit" do
  @list_index = params[:number].to_i
  @list = session[:lists][@list_index]
  erb :edit, layout: :layout
end

# Edit the lists title
post "/lists/:number" do
  list_index = params[:number].to_i
  @list = session[:lists][list_index]
  list_name = params[:list_name].strip
  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :edit, layout: :layout
  else
    @list[:name] = list_name
    session[:success] = "The list has been updated."
    redirect "/lists/#{list_index}"
  end
end

# Delete a list
post "/lists/:number/delete" do
  list_index = params[:number].to_i
  session[:lists].delete_at(list_index)
  session[:success] = "List deleted."
  redirect "/lists"
end

# Add todo to list
post "/lists/:list_id/todos" do
  @list_index = params[:list_id].to_i
  @list = session[:lists][@list_index]
  text = params[:todo].strip
  error = error_for_todo(text)
  if error
    session[:error] = error
    erb :single_list, layout: :layout
  else
    @list[:todos] << {name: text, completed: false}
    session[:success] = "The todo was added."
    redirect "/lists/#{@list_index}"
  end
end

# Delete a single todo
post "/lists/:list_id/todos/:id/destroy" do
  @list_index = params[:list_id].to_i
  @list = session[:lists][@list_index]
  todo_id = params[:id].to_i
  @list[:todos].delete_at(todo_id)
  session[:success] = "The todo has been deleted."
  redirect "/lists/#{@list_index}"
end

# Update the status of a todo
post "/lists/:list_id/todos/:id" do
  @list_index = params[:list_id].to_i
  @list = session[:lists][@list_index]
  todo_id = params[:id].to_i
  is_completed = params[:completed] == "true"
  @list[:todos][todo_id][:completed] = is_completed
  session[:success] = "The todo has been updated."
  redirect "/lists/#{@list_index}"
end

# Mark all todo's as complete for a list
post "/lists/:id/check_all" do
  @list_index = params[:id].to_i
  @list = session[:lists][@list_index]
  @list[:todos].each {|todo| todo[:completed] = true}
  session[:success] = "All todo's marked complete."
  redirect "/lists/#{@list_index}"
end
