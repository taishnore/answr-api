class Api::V1::UsersController < ApplicationController



  def index
    @users = User.all
    #authorized User
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      @token = encode_token(user_id: @user.id)
      render json: {user: UserSerializer.new(@user), jwt: @token}, status: :created
      # user: UserSerializer.new(@user) -- what's the difference from above?
    else
      render json: { error: "failed to create user, please try again" }, status: :not_acceptable
      #how is the error showing?
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
