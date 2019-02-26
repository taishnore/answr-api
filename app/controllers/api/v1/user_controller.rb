class UserController < ApplicationController

  def index
    @users = User.all
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render json: @user
    else
      flash[:error] = @user.errors.full_messages
      #how is the error showing?
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
