require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"

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

get "/" do
  pattern = File.join(data_path, "*")
  @file_list = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  erb :index
end

get "/new" do
  erb :new

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
  file_path = File.join(data_path, params[:filename])
  @file_name = params[:filename]
  @content = File.read(file_path)
  erb :edit
end

post "/:filename" do
  file_path = File.join(data_path, params[:filename])
  File.write(file_path, params[:content])
  session[:success] = "#{params[:filename]} has been updated."
  redirect "/"
end