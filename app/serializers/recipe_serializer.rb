class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :instructions, :minutes_to_complete
end
