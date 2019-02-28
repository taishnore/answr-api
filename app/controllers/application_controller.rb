class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, "taimurs_secret")
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, "taimurs_secret", true, algorithm: "HS256")
        #i don't understand the latter two args.
        #if it decodes, then this will return the decoded token
        #which will be utilized in current_user
      rescue JWT::DecodeError
        nil
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      #if there is a return value, go to the first object
      #and grab the value of the "user_id" key. Then,
      #select the user from the database, and return this user.
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
    # if this returns true, then the user is logged in,
    # and the authorized method does not need to run.
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized
    unless logged_in?
    end
  end

end
end
