class Api::V1::GamesController < ApplicationController

  def index
    @games = Game.all
    render json: @games
  end

  def show
    @game = Game.find(params[:id])
    render json: {game: GameSerializer.new(@game), rounds: @game.rounds}
  end

  def create
    # where can I put these prompts? this is messy!
    @prompts = [
      "Worst gift to bring to a funeral?",
      "I drink to forget ____",
      "Why can't I sleep at night?",
      "Next from JK Rowling: Harry Potter and the Chamber of ____",
      "What are my parents hiding from me?",
      "What helps Obama unwind?",
      "What am I giving up for lent?",
      "What never fails to liven up the party?",
      "What's really at the end of the rainbow?",
      "Charades was ruined for me when my mom had to act out___",
      "This is the time of my life. I'm young, energetic, and full of ___",
      "Next time on Dr. Phil: How to talk to your kids about ___",
      "Hey baby, come back to my place and I'll show you ___"
    ]


    @game = Game.new(title: game_params[:title], number_of_rounds: 3)


    if @game.valid?
      @game.save

      UserGame.create(game_id: @game.id, user_id: params[:user_id])

      # this shuffles the prompts array.
      @shuffledPrompts = @prompts.shuffle.each{ |x| }

      i=0
      9.times do
        Round.create(game_id: @game.id, prompt: @shuffledPrompts[i] )
        i+=1
      end

      @rounds = {
        1 => [
          @game.rounds[0],
          @game.rounds[1],
          @game.rounds[2],
        ],
        2 => [
          @game.rounds[3],
          @game.rounds[4],
          @game.rounds[5],
        ],
        3 => [
          @game.rounds[6],
          @game.rounds[7],
          @game.rounds[8],
        ],
      }


      @users = @game.users


      render json: { game: GameSerializer.new(@game), rounds: @rounds, users: @users }


      serialized_data = ActiveModelSerializers::Adapter::Json.new(GameSerializer.new(@game)).serializable_hash
      ActionCable.server.broadcast "games_channel", serialized_data
    end

  end

  def destroy
    @game = Game.find(params[:id])
    @game_id = params[:id]
    @game.destroy
    ActionCable.server.broadcast "games_channel", { message: "The game has been deleted", id: @game_id }
  end

  def update
    @game = Game.find(params[:id])
    if @game.users.length < 3

      if @game.users.length == 2
        @game.update(is_game_in_play: true)
      end
        @join = UserGame.create(game_id: @game.id, user_id: params[:user_id])
        @game = Game.find(params[:id])
        @rounds = {
          1 => [
            @game.rounds[0],
            @game.rounds[1],
            @game.rounds[2],
          ],
          2 => [
            @game.rounds[3],
            @game.rounds[4],
            @game.rounds[5],
          ],
          3 => [
            @game.rounds[6],
            @game.rounds[7],
            @game.rounds[8],
          ],
        }
        puts "YOYOYOYOYOYOYO"
        puts @game.users
        puts "TOTOTOTOTOTOTO"
        serialized_data = ActiveModelSerializers::Adapter::Json.new(GameSerializer.new(@game)).serializable_hash
        render json: {game: GameSerializer.new(@game), rounds: @rounds, users: @game.users}
        RoundsChannel.broadcast_to @game, serialized_data
    else
      render json: { error: "The game is full" }
    end
  end


  private

  def game_params
    params.require(:game).permit(:title, :user_id)
  end


end
