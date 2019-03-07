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


end
