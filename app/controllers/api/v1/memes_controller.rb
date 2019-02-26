class Api::V1::MemesController < ApplicationController

  def index
    @memes = Meme.all
    render json: @memes
  end

  def show
    @meme = Meme.find(params[:id])
    render json: @meme
  end

  def create
    @meme = Meme.new(meme_params)
    if @meme.valid?
      @meme.save
      render json: @meme
    else
      flash[:error] = @meme.errors.full_messages
      #how to render to front_end?
    end
  end

  def update
    @meme = Meme.find(params[:id])
    @meme.update(meme_params)
    render json: @meme
  end


  private

  def meme_params
    params.require(:meme).permit(:title, :string, :user_id)
  end

end
