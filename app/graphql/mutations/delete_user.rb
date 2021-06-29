# frozen_string_literal: true

module Mutations
  class DeleteUser < BaseMutation
    graphql_name "DeleteUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true

    def resolve(uid:)
      raise GraphQL::ExecutionError, "Authentication failed" if context[:current_user].nil? || context[:current_user]["uid"] != uid
      user = User.find_by(uid: uid)
      user.destroy!

      { user: user }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
      end
  end
end
