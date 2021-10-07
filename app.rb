require 'sinatra/base'
require 'sinatra/reloader'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  before do
    @game = Game.instance
  end

  get '/' do
    erb(:index)
  end

  post '/players' do
    player = Player.new(params[:player_name])
    @game = Game.create(player)
    redirect '/play'
  end

  get '/play' do
    @player_name = @game.player.name
    erb(:play)
  end

  get '/results' do
    p params
    @game.set_moves(params[0])
    @output = @game.output
    erb(:results)
  end

  run! if app_file == $0
end