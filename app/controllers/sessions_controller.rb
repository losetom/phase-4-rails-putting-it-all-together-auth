class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    # If the user's username and password are authenticated
    if user && user.authenticate(params[:password])
      # Save the user's ID in the session hash
      session[:user_id] = user.id
      # Returns a JSON response w/ the user's ID, username, image URL, and bio
      render json: user, status: :created
    else
      # Returns a JSON response with an error message and 401 status code ( unauthorized )
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
