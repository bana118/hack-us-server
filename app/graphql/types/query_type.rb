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
        # TODO パフォーマンスが悪い
        # TODO ソートをSQLのorderで行う
        User.where("JSON_CONTAINS(JSON_EXTRACT(contribution_info, '$[*].language'), ?)", "\"#{language}\"").map { |user|
          contribution_info = JSON.parse(user.contribution_info)
          { **user.attributes, "contribution_info": contribution_info }
        }.sort_by { |user|
          contribution_info = JSON.parse(user["contribution_info"])
          contribution_info.find { |info| info["language"] == language }["contributions"]
        }
      else
        User.all.map { |user |
          contribution_info = JSON.parse(user.contribution_info)
          { **user.attributes, "contribution_info": contribution_info }
        }
      end
    end

    field :user, Types::UserType, null: false do
      argument :uid, String, required: true
    end
    def user(uid:)
      user = User.find_by(uid: uid)
      contribution_info = JSON.parse(user.contribution_info)
      { **user.attributes, "contribution_info": contribution_info }
    end

    field :projects, Types::ProjectType.connection_type, null: false do
      argument :query, String, required: false
    end
    def projects(query: nil)
      if query
        Project.where("name LIKE(?) or description LIKE(?)", "%#{query}%", "%#{query}%").map { |project|
          owner = User.find(project.owner_id)
          languages = JSON.parse(project.languages)
          { **project.attributes, "languages": languages, "owner": owner }
        }
      else
        Project.all.map { |project|
          owner = User.find(project.owner_id)
          languages = JSON.parse(project.languages)
          { **project.attributes, "languages": languages, "owner": owner }
        }
      end
    end

    field :project, Types::ProjectType, null: false do
      argument :id, Int, required: true
    end
    def project(id:)
      project = Project.find(id)
      owner = User.find(project.owner_id)
      languages = JSON.parse(project.languages)
      { **project.attributes, "languages": languages, "owner": owner }
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
      Participant.where(user: user)
    end

    # プロジェクトの参加情報一覧を返す
    field :projectParticipants, Types::ParticipantType.connection_type, null: false do
      argument :project_id, ID, required: true
    end
    def projectParticipants(project_id:)
      project = Project.find(project_id)
      Participant.where(project: project)
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
      Favorite.where(user: user)
    end

    # プロジェクトのお気に入り一覧を返す
    field :projectFavorites, Types::FavoriteType.connection_type, null: false do
      argument :project_id, ID, required: true
    end
    def projectFavorites(project_id:)
      project = Project.find(project_id)
      Favorite.where(project: project)
    end
  end
end
