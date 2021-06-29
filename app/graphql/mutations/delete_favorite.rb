module Mutations
  class DeleteFavorite < BaseMutation
    graphql_name "DeleteFavorite"

    field :favorite, Types::FavoriteType, null: false
    field :result, Boolean, null: true

    argument :id, ID, required: true

    def resolve(**args)
      favorite = Favorite.find(args[:id])
      favorite.destroy
      {
        favorite: favorite,
        result: favorite.errors.blank?
      }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
