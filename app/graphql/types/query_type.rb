# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    def users
      User.all.map do |user|
        contribution_info = JSON.parse(user.contribution_info)
        { **user.attributes, "contribution_info": contribution_info }
      end
    end

    field :user, Types::UserType, null: false do
      argument :uid, String, required: false
    end
    def user(uid:)
      user = User.find_by(uid: uid)
      contribution_info = JSON.parse(user.contribution_info)
      { **user.attributes, "contribution_info": contribution_info }
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

    field :participant, Types::ParticipantType, null: false do
      argument :id, ID, required: false
    end
    def participant(id:)
      Participant.find(id)
    end

    # ユーザの参加情報一覧を返す
    field :userParticipants, [Types::ParticipantType], null: false do
      argument :uid, String, required: false
    end
    def userParticipants(uid:)
      user = User.find_by(uid: uid)
      Participant.where(user: user)
    end

    # プロジェクトの参加情報一覧を返す
    field :projectParticipants, [Types::ParticipantType], null: false do
      argument :project_id, ID, required: false
    end
    def projectParticipants(project_id:)
      project = Project.find(project_id)
      Participant.where(project: project)
    end

    field :favorite, Types::FavoriteType, null: false do
      argument :id, ID, required: false
    end
    def favorite(id:)
      Favorite.find(id)
    end

    # ユーザのお気に入り一覧を返す
    field :userFavorites, [Types::FavoriteType], null: false do
      argument :uid, String, required: false
    end
    def userFavorites(uid:)
      user = User.find_by(uid: uid)
      Favorite.where(user: user)
    end

    # プロジェクトのお気に入り一覧を返す
    field :projectFavorites, [Types::FavoriteType], null: false do
      argument :project_id, ID, required: false
    end
    def projectFavorites(project_id:)
      project = Project.find(project_id)
      Favorite.where(project: project)
    end
  end
end
