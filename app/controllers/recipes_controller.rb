class RecipesController < ApplicationController
    def index
        # If user is logged in ( user_id in session hash )
        if session[:user_id]
            # Returns a JSON reponse w/ an array of all recipes and their title, instructions, time to complete, a nested user object, and 201 status code
            render json: [Recipe.all]
        else 
            render json: { errors: ["Must be logged in"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            recipe = Recipe.create(recipe_params)
            render json: recipe, status: :created
        else
            render json: { errors: ["Invalid data"] }, status: :unprocessable_entity
        end
    end


    private 

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end


end
