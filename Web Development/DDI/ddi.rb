require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get "/" do 
  @title = "Dynamic Directory Index"
  @file_list = Dir.glob("public/*.jpg").map {|file| File.basename(file)}.sort
  @file_list.reverse! if params[:sort] == "desc"
  erb :mainpage
end