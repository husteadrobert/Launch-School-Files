require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

configure do #this is telling Sinatra
  enable :sessions
  set :sessions_secret, 'secret'
end

class Log
  attr_reader :human_history, :computer_history

  def initialize
    @human_history = []
    @computer_history = []
  end

  def update(human_move, computer_move) #Only sending .value here, not a Move object
    @human_history << human_move.value
    @computer_history << computer_move.value
  end

  def each
    @human_history.each_with_index do |symbol, index|
      yield(symbol, @computer_history[index])
    end
  end
end


class Move
  VALUES = ['rock', 'paper', 'scissors'].freeze

  WINNING_COMBINATION = {
    'rock' => 'scissors',
    'paper' => 'rock',
    'scissors' => 'paper'
  }.freeze

  LOSING_COMBINATION = {
    'rock' => 'paper',
    'paper' => 'scissors',
    'scissors' => 'rock'
  }.freeze

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_COMBINATION[@value].include?(other_move.value)
  end

  def <(other_move)
    LOSING_COMBINATION[@value].include?(other_move.value)
  end

  def to_s
    @value
  end

end

helpers do
  def display_result(human_move, computer_move)
    if human_move > computer_move
      "The human wins"
    elsif computer_move > human_move
      "The computer wins"
    else
      "It's a tie"
    end
  end

  def display_history(human_move, computer_move)
    if Move.new(human_move) > Move.new(computer_move)
      "<strong>#{human_move}</strong> v <del>#{computer_move}</del>"
    elsif Move.new(computer_move) > Move.new(human_move)
      "<del>#{human_move}</del> v <strong>#{computer_move}</strong>"
    else
      "#{human_move} v #{computer_move}"
    end
  end
end

def load_users
  path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yaml", __FILE__)
  else
    File.expand_path("../data/users.yaml", __FILE__)
  end
  YAML.load_file(path)
end

def valid_credentials?(username, password)
  users = load_users
  if users.key?(username) && users[username] == password
    true
  else
    false
  end
end

def result(human_move, computer_move)
  if human_move > computer_move
    :human
  elsif computer_move > human_move
    :computer
  else
    :tie
  end
end

get "/" do #Set to 0 at post logout, set to 0 at log in
  session[:human] = 0
  session[:computer] = 0
  session[:tie] = 0
  session[:log] = Log.new
  erb :homepage
end

get "/signin" do
  erb :signin
end

get "/newuser" do
  erb :newuser
end

post "/users/newuser" do
  username = params[:username]
  password = params[:password]
  users = load_users
  users[username] = password

  File.open("data/users.yaml", "r+") do |f|
    f.write(users.to_yaml)
  end
  session[:user] = username
  redirect "/opponents/select"
end

post "/users/signin" do
  username = params[:username]
  password = params[:password]

  if valid_credentials?(username, password) #Set all variables to 0
    session[:user] = username
    redirect "/opponents/select"
  else
    status 422
    erb :signin
  end
end

get "/opponents/select" do
  @ai_list = ["Johnny 5", "Deep Blue", "HAL"]
  erb :select_ai
end

post "/:ai_name/select" do
  session[:ai] = params[:ai_name]
  redirect "/select_throw"
end

get "/select_throw" do
  @log = session[:log]
  @move_list = Move::VALUES
  erb :select_throw
end

post "/human_move/:move" do
  session[:human_move] = Move.new(params[:move])
  session[:computer_move] = Move.new(Move::VALUES.sample)

  redirect "/result"
end

get "/result" do
  winner = result(session[:human_move], session[:computer_move])
  session[:log].update(session[:human_move], session[:computer_move])
  session[winner] += 1
  @log = session[:log]
  erb :result
end