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

get "/lists/:number/edit" do
  list_index = params[:number].to_i
  @list = session[:lists][list_index]
  erb :edit, layout: :layout
end