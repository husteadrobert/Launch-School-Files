require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"
require "yaml"
require "bcrypt"

configure do #this is telling Sinatra
  enable :sessions
  set :sessions_secret, 'secret'
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

def load_users
  path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yaml", __FILE__)
  else
    File.expand_path("../users.yaml", __FILE__)
  end
  YAML.load_file(path)
end

def valid_credentials?(username, password)
  user_list = load_users
  if user_list.key?(username)
    b_password = BCrypt::Password.new(user_list[username]) #Decrypting/Dehashing password here
    b_password == password
  else
    false
  end
end


def render_markdown(text) #Renders Markdown text into HTML
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text)
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when ".txt"
    headers["Content-Type"] = "text/plain"
    content
  when ".md"
    erb render_markdown(content)
  end
end

def signed_in?
  session[:user]
end

def require_signin
  unless signed_in?
    session[:error] = "You must be signed in to do that."
    redirect "/"
  end
end

get "/" do
  pattern = File.join(data_path, "*")
  @file_list = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  @username = session[:user]
  erb :index
end

get "/new" do
  require_signin
  erb :new
end

post "/new" do #Must be before "post /:filename"
  require_signin
  filename = params[:file_name].to_s
  if filename.size > 0
    file_path = File.join(data_path, filename)
    File.write(file_path, "")
    session[:success] = "#{filename} has been created"
    redirect "/"
  else
    session[:error] = "Please input a file name."
    status 422
    erb :new
  end
end

post "/:filename/delete" do
  require_signin
  file_path = File.join(data_path, params[:filename])
  File.delete(file_path)
  session[:success] = "#{params[:filename]} has been deleted."
  redirect "/"
end


get "/:filename" do
  file_path = File.join(data_path, params[:filename])
  if File.exist?(file_path)
    load_file_content(file_path)
  else
    session[:error] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
    require_signin
    file_path = File.join(data_path, params[:filename])
    @file_name = params[:filename]
    @content = File.read(file_path)
    erb :edit
end

post "/users/signin" do
  username = params[:username]
  password = params[:password]

  if valid_credentials?(username, password)
    session[:user] = username
    session[:success] = "Welcome!"
    redirect "/"
  else
    session[:error] = "Invalid credentials"
    status 422
    erb :signin
  end
end

post "/:filename" do
  require_signin
  file_path = File.join(data_path, params[:filename])
  File.write(file_path, params[:content])
  session[:success] = "#{params[:filename]} has been updated."
  redirect "/"
end

get "/users/signin" do
  erb :signin
end

post "/users/signout" do
  session.delete(:user)
  session[:success] = "You have been signed out."
  redirect "/"
end
