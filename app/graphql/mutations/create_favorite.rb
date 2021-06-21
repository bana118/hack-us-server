# frozen_string_literal: true

module Mutations
  class CreateFavorite < BaseMutation
    graphql_name "CreateFavorite"

    field :favorite, Types::FavoriteType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :project_id, ID, required: true

    def resolve(uid:, project_id:)
      user = User.find_by(uid: uid)
      project = Project.find(project_id)
      favorite = Favorite.create(user: user, project: project)

      if favorite.save
        { favorite: favorite }
      else
        raise GraphQL::ExecutionError, favorite.errors.full_messages.join(", ")
      end
    end
  end
end
