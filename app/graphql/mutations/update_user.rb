# frozen_string_literal: true

module Mutations
  class UpdateUser < BaseMutation
    graphql_name "UpdateUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :name, String, required: false
    argument :description, String, required: false

    def resolve(uid:, name:, description:)
      raise GraphQL::ExecutionError, "Authentication failed" if context[:current_user].nil? || context[:current_user]["uid"] != uid
      arg = { name: name, description: description }
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
