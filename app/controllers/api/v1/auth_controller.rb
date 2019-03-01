class Api::V1::AuthController < ApplicationController #this is, i think, to handle an already existing user logging in.
  skip_before_action :authorized, only: [:create]
  #so that the user can login before the authorized method runs,
  #which sees whether the user is logged in.

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

private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end


end
