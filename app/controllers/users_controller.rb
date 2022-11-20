class UsersController < ApplicationController

    def create
        # Saves new user to DB w/ username, pwd, image URL, and bio 
        user = User.create(user_params)
        if user && user.valid?
        # Saves the user's ID in the session hash
            session[:user_id] = user.id
            # Renders JSON response w/ created status code ( 201 )
            render json: user, status: :created
        else
            # Returns JSON response w/ error messages and HTTP status ( 422 )
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        # If the user is logged in ( user_id in sesssion hash )
        if session[:user_id]
            # Returns a JSON response w/ user's ID, username, image URL, and bio
            user = User.find(session[:user_id])
            # Returns an HTTP status code of 201 ( created )
            render json: user, status: :created
        else
            # Returns a JSON response with error message and status code of 401 ( unauthorized )
            render json: { errors: "Must be logged in" }, status: :unauthorized
        end
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    # def find_camper
    #     User.find(params[:id])
    # end
end
