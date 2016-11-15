require 'yaml'
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @file = Psych.load_file("data.yaml")
  @name_list = @file.keys.map(&:to_s)
  @total_users = @name_list.count
end

helpers do
  def total_interests
    total_interests = 0
    @file.each_value {|value| total_interests += value[:interests].count}
    "#{total_interests}"
  end
end

not_found do
  redirect "/"
end

get "/" do
  erb :home
end

get "/user/:name" do
  @name = params[:name].to_s
  @email_address = @file[:"#{@name}"][:email]
  @interests = @file[:"#{@name}"][:interests].join(", ")
  erb :user
end