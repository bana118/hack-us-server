# frozen_string_literal: true

module Mutations
  class DeleteFavorite < BaseMutation
    graphql_name "DeleteFavorite"

    field :favorite, Types::FavoriteType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :project_id, ID, required: true

    # uid, project_id をもとに検索
    def resolve(uid:, project_id:)
      user = User.find_by(uid: uid)
      project = Project.find(project_id)

      favorite = Favorite.find_by(user: user, project: project)
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
