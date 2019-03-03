require 'byebug'

class ApplicationController < ActionController::API
  # before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, "taimurs_secret")
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header
      JWT.decode(token, "taimurs_secret")[0]
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token['user_id']

      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  # def authorized
  #   render json: { message: "Please log in" }, status: :unauthorized
  #   unless logged_in?
  #   end
  # end

end
