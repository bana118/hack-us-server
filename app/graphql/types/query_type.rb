# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, Types::UserType.connection_type, null: false do
      argument :language, String, required: false
    end
    def users(language: nil)
      if language
        User.has_language_contribution(language)
      else
        User.all.order(:name)
      end
    end

    field :user, Types::UserType, null: false do
      argument :uid, String, required: true
    end
    def user(uid:)
      User.find_by(uid: uid)
    end

    field :projects, Types::ProjectType.connection_type, null: false do
      argument :query, String, required: false
    end
    def projects(query: nil)
      if query
        Project.joins(:languages).where("projects.name LIKE(?) or description LIKE(?) or languages.name LIKE(?)", "%#{query}%", "%#{query}%", "%#{query}%")
        .distinct.order(created_at: "DESC")
      else
        Project.all.order(created_at: "DESC")
      end
    end

    field :recommends, [Types::RecommendType], null: false do
      argument :uid, String, required: true
      argument :language_first, Int, required: true
      argument :project_first, Int, required: true
    end
    def recommends(uid:, language_first:, project_first:)
      user = User.find_by(uid: uid)
      user.contributions.slice(0, language_first).map do |contribution|
        language = contribution.language
        projects = Project.joins(:languages).where("projects.name LIKE(?) or description LIKE(?) or languages.name LIKE(?)", "%#{language}%", "%#{language}%", "%#{language}%")
                    .distinct
                    .order(created_at: "DESC")
                    .first(project_first)
        { "language": language, "projects": projects }
      end
    end

    field :project, Types::ProjectType, null: false do
      argument :id, ID, required: true
    end
    def project(id:)
      Project.find(id)
    end

    field :participant, Types::ParticipantType, null: false do
      argument :id, ID, required: true
    end
    def participant(id:)
      Participant.find(id)
    end

    # ユーザの参加情報一覧を返す
    field :userParticipants, Types::ParticipantType.connection_type, null: false do
      argument :uid, String, required: true
    end
    def userParticipants(uid:)
      user = User.find_by(uid: uid)
      Participant.where(user: user).order(created_at: "DESC")
    end

    # プロジェクトの参加情報一覧を返す
    field :projectParticipants, Types::ParticipantType.connection_type, null: false do
      argument :project_id, ID, required: true
    end
    def projectParticipants(project_id:)
      project = Project.find(project_id)
      Participant.where(project: project).order(created_at: "DESC")
    end

    field :favorite, Types::FavoriteType, null: false do
      argument :id, ID, required: true
    end
    def favorite(id:)
      Favorite.find(id)
    end

    # ユーザのお気に入り一覧を返す
    field :userFavorites, Types::FavoriteType.connection_type, null: false do
      argument :uid, String, required: true
    end
    def userFavorites(uid:)
      user = User.find_by(uid: uid)
      Favorite.where(user: user).order(created_at: "DESC")
    end

    # プロジェクトのお気に入り一覧を返す
    field :projectFavorites, Types::FavoriteType.connection_type, null: false do
      argument :project_id, ID, required: true
    end
    def projectFavorites(project_id:)
      project = Project.find(project_id)
      Favorite.where(project: project).order(created_at: "DESC")
    end
  end
end
