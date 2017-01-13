require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

configure do #this is telling Sinatra
  enable :sessions
  set :sessions_secret, 'secret'
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
  def result(human_move, computer_move)
    if human_move > computer_move
      "The human wins"
    elsif computer_move > human_move
      "The computer wins"
    else
      "It's a tie"
    end
  end
end


get "/" do
  erb :homepage
end

get "/opponents/select" do
  @ai_list = ["Random", "Johnny 5", "Deep Blue", "HAL"]
  erb :select_ai
end

post "/:ai_name/select" do
  session[:ai] = params[:ai_name]
  redirect "/select_throw"
end

get "/select_throw" do
  @move_list = Move::VALUES
  erb :select_throw
end

post "/human_move/:move" do
  session[:human_move] = Move.new(params[:move])
  session[:computer_move] = Move.new(Move::VALUES.sample)
  redirect "/"
end