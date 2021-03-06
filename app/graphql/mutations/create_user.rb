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
      contributions = GithubUtils::GraphqlApi.get_contributions(github_id)

      user = User.create(name: name, uid: uid, description: "", github_id: github_id, github_icon_url: picture)
      contributions.each do |contribution|
        user.contributions.create(language: contribution[:language], color: contribution[:color], count: contribution[:count])
      end
      {
        user: user,
        result: user.errors.blank?,
      }
    end
  end
end
