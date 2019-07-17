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
    # @round = Game.find(round_params[:game_id]).rounds.find(round_params[:round_id])
    # @answer = Answer.create(user_id: round_params[:user_id], round_id: round_params[:round_id], answer_text: round_params[:answer_text])

    # RoundsChannel.broadcast_to @game, {answer: `#{@answer.answer_text}`, user_id: `#{@answer.user_id}`}
    RoundsChannel.broadcast_to @game, {new_answer: "there has been an answer"}
  end

  def increment
    puts params
    @game = Game.find(params[:game_id])
    RoundsChannel.broadcast_to @game, {increment: "time to increment"}
  end

  private

  def round_params
    params.require(:round).permit(:round_id, :user_id, :answer_text, :game_id)
  end


end
