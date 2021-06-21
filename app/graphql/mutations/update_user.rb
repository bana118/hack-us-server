# frozen_string_literal: true

module Mutations
  class UpdateUser < BaseMutation
    graphql_name "UpdateUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :name, String
    argument :description, String
    argument :github_id, String

    def resolve(uid:, name:, description:, github_id:)
      raise GraphQL::ExecutionError, "Authentication failed" if context[:current_user].nil? || context[:current_user]["uid"] != uid
      arg = { name: name, description: description, github_id: github_id }
      updates = arg.compact
      user = User.find_by(uid: uid)
      user.update(updates)
      {
        user: user,
        result: user.errors.blank?,
      }
    end
  end
end
