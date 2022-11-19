class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: ["Invalid credentials"] }, status: :unauthorized
    end
  end

  def destroy
    if session.delete :user_id
      head :no_content
    else
      render json: { errors: ["No content found"] }, status: :unauthorized
    end
  end

end
