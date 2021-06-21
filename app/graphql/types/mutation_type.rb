# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createProject, mutation: Mutations::CreateProject
    field :createUser, mutation: Mutations::CreateUser
    field :createParticipant, mutation: Mutations::CreateParticipant
    field :createFavorite, mutation: Mutations::CreateFavorite
  end
end
