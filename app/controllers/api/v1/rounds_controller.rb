class Api::V1::RoundsController < ApplicationController

  def index
    @rounds = Round.all
    render json: @rounds
  end

  def start
    puts params
    @game = Game.find(params[:game_id])
    RoundsChannel.broadcast_to @game, {start: "Start game"}
  end

  def answer
    puts params
    @round = Game.find(params[:game_id]).rounds.find(params[:round_id])
    @answer = Answer.create(user_id: params[:user_id], round_id: params[:round_id], answer_text: params[:answer_text])
    @game = Game.find(params[:game_id])
    RoundsChannel.broadcast_to @game, {answer: @answer.answer_text, user_id: @answer.user_id}
  end


  def increment
    puts params
    @game = Game.find(params[:gameId])

    if params[:type] == "prompt"
      RoundsChannel.broadcast_to @game, {increment: "prompt"}
    elsif params[:type] == "round"
      RoundsChannel.broadcast_to @game, {increment: "round"}
    elsif params[:type] == "end"
      RoundsChannel.broadcast_to @game, {increment: "end"}
    end


  end

  def update

    @round = Round.find(params[:roundId])
    @round.update(winner_id: params[:userId])

    @round = Round.find(params[:roundId])

    @name = User.find{|user| user.id == params[:userId]}.name

    @game = Game.find(params[:gameId])

    RoundsChannel.broadcast_to @game, {winner: @name}

  end

  private

  def round_params
    params.require(:round).permit(:round_id, :user_id, :answer_text, :game_id)
  end


end
