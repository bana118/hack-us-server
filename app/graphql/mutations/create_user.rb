# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    graphql_name "CreateUser"

    field :user, Types::UserType, null: false
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :uid, String, required: true

    def resolve(name:, uid:)
      user = User.create(name: name, uid: uid)
      {
        user: user,
        result: user.errors.blank?
      }
    end
  end
end
