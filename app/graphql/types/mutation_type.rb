# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createProject, mutation: Mutations::CreateProject
    field :createUser, mutation: Mutations::CreateUser
  end
end
