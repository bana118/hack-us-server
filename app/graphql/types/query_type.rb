# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :uid, String, required: false
    end
    def user(uid:)
      User.find_by(uid: uid)
    end

    field :projects, [Types::ProjectType], null: false
    def projects
      Project.all
    end

    field :project, Types::ProjectType, null: false do
      argument :id, Int, required: false
    end
    def project(id:)
      Project.find(id)
    end

    field :paticipant, Types::ParticipantType, null: false do
      argument :id, ID, required: false
    end
    def paticipant(id:)
      Paticipant.find(id)
    end

    # ユーザの参加情報一覧を返す
    field :userParticipants, [Types::ParticipantType], null: false do
      argument :uid, String, required: false
    end
    def userParticipants(uid:)
      user = User.find_by(uid: uid)
      Participant.where(user: user)
    end

    field :favorite, Types::FavoriteType, null: false do
      argument :id, ID, required: false
    end
    def favorite(id:)
      Favorite.find(id)
    end
  end
end
