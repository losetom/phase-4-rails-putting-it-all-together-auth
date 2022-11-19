class UsersController < ApplicationController

    def create
        # Saves new user to DB w/ username, pwd, image URL, and bio 
        user = User.create(user_params)
        if user && user.valid?
        # Saves the user's ID in the session hash
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # Returns JSON response w/ error messages and HTTP status ( 422 )
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user, status: :created
        else
            render json: { errors: "Must be logged in"}, status: :unauthorized
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
