class Api::V1::AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create]


  #
  def create
    @user = User.find_by(email: user_login_params[:email])
    if @user && @user.authenticate(user_login_params[:password])
      @token = encode_token({user_id: @user.id})
      #this creates a token that basically acts like sessions;
      #is it what allows the user to make API requests
      render json: {user: UserSerializer.new(@user), jwt: @token}, status: :created
    else
      render json: {error: "Login unsuccesful, please try again"}, status: :not_acceptable
    end
  end

  def show

    @user = current_user
    if @user
      render json: {user: @user}, status: :accepted
    else
      render json: { message: 'I am making progress' }, status: :unauthorized
    end
  end

private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end


end
