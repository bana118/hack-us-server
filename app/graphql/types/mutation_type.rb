# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createUser, mutation: Mutations::CreateUser
  end
end
