require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"

configure do #this is telling Sinatra
  enable :sessions
  set :sessions_secret, 'secret'
end

def render_markdown(text)
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
    render_markdown(content)
  end
end


root = File.expand_path("..", __FILE__) #Unsure whats going on here

get "/" do
  @file_list = Dir.glob(root + "/data/*").map do |path|
    File.basename(path)
  end
  erb :index
end

get "/:filename" do
  file_path = root + "/data/" + params[:filename]
  if File.exist?(file_path)
    load_file_content(file_path)
  else
    session[:error] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
  file_path = root + "/data/" + params[:filename]
  @file_name = params[:filename]
  @content = File.read(file_path)
  erb :edit
end

post "/:filename" do
  file_path = root + "/data/" + params[:filename]
  File.write(file_path, params[:content])
  session[:success] = "#{params[:filename]} has been updated."
  redirect "/"
end