class ApplicationController < ActionController::Base
  before_action :authorized
  protect_from_forgery with: :null_session

  def jwt_key
    Rails.application.credentials.jwt_key
  end

  def issue_token(user, expiration_date = 24.hours.from_now)
    JWT.encode({ user_id: user.id, exp: expiration_date.to_i }, jwt_key, "HS256")
  end

  def decoded_token
    if token.present?
      begin
        JWT.decode(token, jwt_key, true, { :algorithm => "HS256" })
      rescue JWT::DecodeError
        [{ error: "Invalid Token" }]
      end
    else
      [{ error: "Missing Token" }]
    end
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end

  def token
    authorization_header = request.headers["Authorization"]

    if authorization_header.present?
      authorization_header.split(" ").last
    end
  end

  def user_id
    decoded_token.first["user_id"]
  end

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end
end
