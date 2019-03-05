

class Api::V1::GamesController < ApplicationController

  @prompts = [
    "Worst gift to bring to a funeral?",
    "Avi's deep and dark secret?",
    "I drink to forget ____",
    "Douchey custom license plate"
   ]


  def index
    @games = Game.all
    render json: @games
  end

  def show
    @game = Game.find(params[:id])
    render json: {game: GameSerializer.new(@game), rounds: @game.rounds}
  end

  def create
    @prompts = [
      "Worst gift to bring to a funeral?",
      "Avi's deep and dark secret?",
      "I drink to forget ____",
      "Douchey custom license plate"
     ]
    @game = Game.new(game_params)
    if @game.valid?
      @game.save
      UserGame.create(game_id: @game.id, user_id: params[:user_id])
      #where is the user_id coming from?
      #i forsee this being a bug.
      i = 0 
      loop do
        Round.create(game_id: @game.id, prompt: @prompts.sample )
        i += 1
        if i == game_params[:number_of_rounds]
          break
        end
      end
      render json: { game: GameSerializer.new(@game) }
    end
  end



  private

  def game_params
    params.require(:game).permit(:title, :number_of_rounds)
  end


end
