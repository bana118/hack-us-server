# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    graphql_name "CreateUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :github_id, String, required: true
    argument :github_access_token, String, required: true

    def resolve(uid:, github_id:, github_access_token:)
      raise GraphQL::ExecutionError, "Authentication failed" if context[:current_user].nil? || context[:current_user]["uid"] != uid
      contributions = GithubUtils::GraphqlApi.get_contributions(github_access_token)
      name =  context[:current_user]["decoded_token"][:payload]["name"]
      picture = context[:current_user]["decoded_token"][:payload]["picture"]

      user = User.create(name: name, uid: uid, description: "", github_id: github_id, github_icon_url: picture)
      {
        user: user,
        result: user.errors.blank?,
      }
    end
  end
end
