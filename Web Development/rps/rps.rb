require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"
require "bcrypt"

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

def load_fame
  path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/hall_of_fame.yaml", __FILE__)
  else
    File.expand_path("../data/hall_of_fame.yaml", __FILE__)
  end
  YAML.load_file(path)
end

#IN PROGRESS
def update_hall(username, winning_streak, computer_name)
  hall = load_fame
  new_entry = {"name" => username, "score" => winning_streak, "opponent" => computer_name}
  insert_index = case 
                 when winning_streak > hall[0]["score"]
                  0
                 when winning_streak > hall[1]["score"]
                  1
                 else
                  2
                 end
  hall.insert(insert_index, new_entry)
  hall.delete_at(3)
  File.open("data/hall_of_fame.yaml", "r+") do |f|
    f.write(hall.to_yaml)
  end
end

#IN PROGRESS
def enter_hall?(winning_streak)
  hall = load_fame
  lowest_score = hall[2]["score"]
  winning_streak > lowest_score
end

def valid_credentials?(username, password)
  users = load_users
  if users.key?(username) && BCrypt::Password.new(users[username]) == password
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

def valid_newuser?(username, password)
  if username.strip.size < 1
    "Username must be at least 1 character in length."
  elsif password.size < 5
    "Password must be at least 5 characters in length."
  end
end

get "/" do
  session[:user] = nil
  erb :homepage
end

get "/hall_of_fame" do
  @hall = load_fame
  erb :hall_of_fame
end

get "/signin" do
  erb :signin
end

get "/newuser" do
  erb :newuser
end

post "/users/newuser" do

  username = params[:username].strip
  password = params[:password]
  error = valid_newuser?(username, password)
  if error
    session[:message] = error
    erb :"/newuser"
  else
    encrypted_password = BCrypt::Password.create(password)
    users = load_users
    users[username] = encrypted_password

    File.open("data/users.yaml", "r+") do |f|
      f.write(users.to_yaml)
    end
    session[:user] = username
    redirect "/opponents/select"
  end
end

post "/users/signin" do
  username = params[:username]
  password = params[:password]

  if valid_credentials?(username, password)
    session[:user] = username
    redirect "/opponents/select"
  else
    session[:message] = "Please try again."
    status 422
    erb :signin
  end
end

get "/opponents/select" do
  session[:human] = 0
  session[:computer] = 0
  session[:tie] = 0
  session[:log] = Log.new
  session[:winning_streak] = 0
  unless session[:user]
    session[:user] = "Guest"
  end
  @ai_list = ["Johnny 5", "Deep Blue", "HAL"]
  session[:message] = "Signed in as #{session[:user]}."
  erb :select_ai
end

post "/:ai_name/select" do
  session[:ai] = params[:ai_name]
  redirect "/select_throw"
end

get "/select_throw" do
  @log = session[:log]
  @move_list = Move::VALUES
  session[:message] = "Signed in as #{session[:user]}."
  erb :select_throw
end

post "/human_move/:move" do
  session[:human_move] = Move.new(params[:move])
  session[:computer_move] = Move.new(Move::VALUES.sample)

  redirect "/result"
end

get "/result" do
  winner = result(session[:human_move], session[:computer_move])
  if winner == :human
    session[:winning_streak] += 1
  elsif winner == :computer
    if enter_hall?(session[:winning_streak])
      session[:message] = "You've entered the Hall of Fame!"
      update_hall(session[:user], session[:winning_streak], session[:ai])
    end
    session[:winning_streak] = 0
  end
  session[:log].update(session[:human_move], session[:computer_move])
  session[winner] += 1
  @log = session[:log]
  erb :result
end