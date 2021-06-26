# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    graphql_name "CreateUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :github_id, String, required: true

    def resolve(uid:, github_id:)
      raise GraphQL::ExecutionError, "Authentication failed" if context[:current_user].nil? || context[:current_user]["uid"] != uid
      name =  context[:current_user]["decoded_token"][:payload]["name"] || github_id
      picture = context[:current_user]["decoded_token"][:payload]["picture"]
      contribution_info = GithubUtils::GraphqlApi.get_contribution_info(github_id).to_json

      user = User.create(name: name, uid: uid, description: "", github_id: github_id, github_icon_url: picture, contribution_info: contribution_info)
      {
        user: user,
        result: user.errors.blank?,
      }
    end
  end
end
