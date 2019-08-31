class Api::V1::GamesController < ApplicationController

##gotta fix everything.
@@PROMPTS = [
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
@@ROUNDS_PER_GAME = 3
@@MAX_PLAYERS_PER_GAME = 3

  def index
    @games = Game.all
    render json: @games
  end

  def show
    @game = Game.find(params[:id])
    render json: {game: GameSerializer.new(@game), rounds: @game.rounds}
  end

  def create
    @game_title = game_params[:title]
    @player_one_id = params[:user_id]

    @game = Game.new(title: @game_title, number_of_rounds: @@ROUNDS_PER_GAME, player_one_id: @player_one_id)

    ##what if the game isn't valid?
    ##checks up front, then write as if it's valid

    if @game.valid?
      @game.save

      UserGame.create(game_id: @game.id, user_id: @player_one_id)

      # this shuffles the prompts array.
      @shuffledPrompts = @@PROMPTS.shuffle.each{ |x| }

      i = 0
      9.times do
        Round.create(game_id: @game.id, prompt: @shuffledPrompts[i] )
        i += 1
      end

      ##TODO could change the name of "rounds" to "prompts"
      ##TODO use a loop here
      ##could move this logic to a privateMethod or something
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

      ##can move these two lines to a model method where I pass in user_id
      @users = @game.users
      @player_one = @users.find{ |user| user.id == @game.player_one_id}

      render json: { game: GameSerializer.new(@game), rounds: @rounds, users: @users, player_one: @player_one }

      #model method on the class for the serializer
      # def serialized_data(@game) get more specific with name
      #
      # end
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
    @game_id = params[:id]
    @user_id = params[:user_id]
    @game = Game.find(@game_id)
    @player_count = @game.users.length

    if @player_count >= @@MAX_PLAYERS_PER_GAME
      render json: { error: "The game is full" }
      return
    end

    if @game.users.length === @@MAX_PLAYERS_PER_GAME
      @game.update(is_game_in_play: true)
    end

    # TODO better variable name
    @join = UserGame.create(game_id: @game_id, user_id: @user_id)

    #TODO this can be the separate method from earlier
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

    ##TODO refactor to be cleaner && clearer logic
    if @game.users.length === @@MAX_PLAYERS_PER_GAME - 1

      @game.update(player_two_id: @user_id )
      @player_one = @game.users.find{ |user| user.id == @game.player_one_id}
      @player_two = @game.users.find{|user| user.id == @game.player_two_id}
      render json: {game: GameSerializer.new(@game), rounds: @rounds, users: @game.users, player_one: @player_one, player_two: @player_two}
    elsif @game.users.length === @@MAX_PLAYERS_PER_GAME

      @game.update(player_three_id: @user_id )

      @player_one = @game.users.find{ |user| user.id == @game.player_one_id}
      @player_two = @game.users.find{|user| user.id == @game.player_two_id}
      @player_three = @game.users.find{|user| user.id == @game.player_three_id}

      render json: {game: GameSerializer.new(@game), rounds: @rounds, users: @game.users, player_one: @player_one, player_two: @player_two, player_three: @player_three}
    end

    serialized_data = ActiveModelSerializers::Adapter::Json.new(GameSerializer.new(@game)).serializable_hash
    RoundsChannel.broadcast_to @game, serialized_data

  end

  private

  def game_params
    params.require(:game).permit(:title, :user_id)
  end

end
